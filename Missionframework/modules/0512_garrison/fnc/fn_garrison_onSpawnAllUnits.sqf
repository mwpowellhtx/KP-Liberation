#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSpawnAllUnits

    File: fn_garrison_onSpawnAllUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 10:10:16
    Last Update: 2021-05-03 10:10:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates ALL UNITS associated with the sector GARRISON.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The function has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/getPos#Alternative_Syntax_2
        https://community.bistudio.com/wiki/nearestObjects
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    +KPLIB_zeroPos
    , KPLIB_param_sectors_capRange
    , _namespace getVariable [QMVAR(_markerName), []]
    , _namespace getVariable [QMVAR(_markerPos), +KPLIB_zeroPos]
    , _namespace getVariable [QMVAR(_garrison), []]
    , _namespace getVariable QMVAR(_positions) // Yes because NIL is possible
    , [_namespace, KPLIB_sectors_status_garrisoning, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
    , [_namespace, KPLIB_sectors_status_garrisoned, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
    , [_namespace] call KPLIB_fnc_sectors_getSide;
] params [
    Q(_zeroPos)
    , Q(_capRange)
    , Q(_markerName)
    , Q(_markerPos)
    , Q(_garrison)
    , Q(_positions)
    , Q(_garrisoning)
    , Q(_garrisoned)
    , Q(_side)
];

// Sector not yet GARRISONING or has already GARRISONED
if (!_garrisoning || _garrisoned || _markerPos isEqualTo _zeroPos) exitWith {
    false;
};

_garrison params [
    [Q(_groupedUnitClassNames), [], [[]]]
];

private _grpCount = count _groupedUnitClassNames;

// Establish some reference positions
if (isNil { _positions; }) then {
    _positions = [
        [_markerPos, _capRange, _grpCount] call KPLIB_fnc_common_calculateRadialPositions
    ] call BIS_fnc_arrayShuffle;
    _namespace setVariable [QMVAR(_positions), _positions];
};

private _grps = _groupsUnitClassNames apply {
    private _classNames = _x;
    private _targetPos = _positions deleteAt 0;
    private _spawnPositions = [_targetPos, _capRange] call KPLIB_fnc_common_getNearestSpawnPositions;
    if (!(_spawnPositions isEqualTo [])) then { _targetPos = selectRandom _spawnPositions; };
    [_classNames, _targetPos, _side] call KPLIB_fnc_common_createGroup;
};

private _units = [[], _grps apply { units _x; }] call KPLIB_fnc_linq_aggregate;

_namespace setVariable [QMVAR(_units), _units];

true;
