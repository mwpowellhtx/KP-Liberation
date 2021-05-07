#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningSpawnIeds

    File: fn_garrison_onGarrisoningSpawnIeds.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 13:02:56
    Last Update: 2021-05-06 13:02:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        ...

    Parameter(s):
        _namespace - a CBA SECTOR namespace being garrisoned for IED bits
            [LOCATION, default: locationNull]
        _targetClassNames - the TARGET CLASS NAMES being spawned [ARRAY, default: []]

    Returns:
        The created IED objects [ARRAY]

    References:
        https://community.bistudio.com/wiki/buildingPos
        https://community.bistudio.com/wiki/createVehicle
        https://community.bistudio.com/wiki/nearestObjects
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
        https://dictionary.com/browse/stochastic
        https://sciencedirect.com/topics/earth-and-planetary-sciences/stochasticity
        https://en.wikipedia.org/wiki/Stochastic
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_targetClassNames), [], [[]]]
];

private _debug = MPARAM(_onGarrisoningSpawnIeds_debug)
    || (_namespace getVariable [QMVAR(_onGarrisoningSpawnIeds_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_markerPos), +KPLIB_zeroPos]
    , _namespace getVariable [QMVAR(_garrison), []]
    , _namespace getVariable QMVAR(_actualIedClassNames)
    , _namespace getVariable QMVAR(_ieds)
] params [
    Q(_markerName)
    , Q(_markerPos)
    , Q(_garrison)
    , Q(_actualIedClassNames)
    , Q(_ieds)
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnIeds] Entering: [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]: %1"
        , str [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Preclude duplicate garrison
if (!isNil { _actualIedClassNames; }) exitWith {
    if (_debug) then {
        [format ["[fn_garrison_onGarrisoningSpawnIeds] Already spawned: [_markerName, markerText _markerName, count _actualIedClassNames, _actualIedClassNames]: %1"
            , str [_markerName, markerText _markerName, count _actualIedClassNames, _actualIedClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
    };
    // Re-set the ACTUAL INTEL CLASS NAMES
    _garrison set [MPRESET(_garrisonIndex_ieds), +_actualIedClassNames];
    _namespace setVariable [QMVAR(_garrison), +_garrison];
    _ieds;
};

_ieds = _targetClassNames apply { [_x, _markerPos] call KPLIB_fnc_ieds_createOne; };
_actualIedClassNames = _ieds apply { typeOf _x; };

{ _namespace setVariable _x; } forEach [
    [QMVAR(_ieds), _ieds]
    , [QMVAR(_actualIedClassNames), +_actualIedClassNames]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnIeds] Fini: [_markerName, markerText _markerName, count _actualIedClassNames, _actualIedClassNames]: %1"
        , str [_markerName, markerText _markerName, count _actualIedClassNames, _actualIedClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_ieds;
