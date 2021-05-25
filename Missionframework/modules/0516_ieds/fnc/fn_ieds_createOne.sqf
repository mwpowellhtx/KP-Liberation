#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_createOne

    File: fn_ieds_createOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 14:02:14
    Last Update: 2021-05-07 14:07:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a new triggered IED.

    Parameter(s):
        _className - the IED class name being created [STRING, default: ""]
        _targetPos - [POSITION, default: KPLIB_zeroPos]
        _range - [SCALAR, default: KPLIB_param_sectors_capRange]

    Returns:
        The created IED object [BOOL]

    References:
        https://community.bistudio.com/wiki/createMine#Syntax
 */

private _debug = MPARAM(_createOne_debug);

params [
    [Q(_className), "", [""]]
    , [Q(_targetPos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_range), KPLIB_param_sectors_capRange, [0]]
];

[
    objNull
    , [_targetPos, _range] call MFUNC(_getRoads)
] params [
    Q(_target)
    , Q(_roads)
];

if (_className isEqualTo "") exitWith {
    _target;
};

// TODO: TBD may do so 'in the ground' (?)
private _spawnPos = [_roads, _className] call MFUNC(_getSpawnPos);

if (!(_spawnPos isEqualTo KPLIB_zeroPos)) then {
    // TODO: TBD: no markers, for now, but that should be considered as an option...
    private _markers = [];
    _target = createMine [_className, _spawnPos, _markers, 0];
    _target setVariable [QMVAR(_className), _className, true];

    // We can probably get away with a server only event after all
    [Q(KPLIB_vehicle_created), [_target]] call CBA_fnc_serverEvent;
};

_target;
