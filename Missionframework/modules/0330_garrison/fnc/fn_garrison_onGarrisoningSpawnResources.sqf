#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningSpawnResources

    File: fn_garrison_onGarrisoningSpawnResources.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 11:31:44
    Last Update: 2021-05-06 02:06:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Garrisons spawned RESOURCE CRATES for the given SECTOR.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _targetClassNames - the TARGET CLASS NAMES being spawned [ARRAY, default: []]

    Returns:
        The created objects [ARRAY]

    References:
        https://community.bistudio.com/wiki/findEmptyPosition
        https://community.bistudio.com/wiki/nearestObjects
        https://community.bistudio.com/wiki/BIS_fnc_randomPos
        https://community.bistudio.com/wiki/BIS_fnc_findSafePos
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_targetClassNames), [], [[]]]
];

private _debug = MPARAM(_onGarrisoningSpawnResources_debug)
    || (_namespace getVariable [QMVAR(_onGarrisoningSpawnResources_debug), false]);

[
    KPLIB_param_sectors_capRange
    , _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_markerPos), +KPLIB_zeroPos]
    , _namespace getVariable [QMVAR(_garrison), []]
    , _namespace getVariable [QMVAR(_resources), []]
    , _namespace getVariable [QMVAR(_spawnResources), true]
    , [_namespace] call KPLIB_fnc_sectors_getSide
] params [
    Q(_capRange)
    , Q(_markerName)
    , Q(_markerPos)
    , Q(_garrison)
    , Q(_resources)
    , Q(_spawnResources)
    , Q(_side)
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnResources] Entering: [_markerName, markerText _markerName, _markerPos, _spawnResources, _targetClassNames]: %1"
        , str [_markerName, markerText _markerName, _markerPos, _spawnResources, _targetClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Sector has already spawned RESOURCES
if (!_spawnResources) exitWith {
    if (_debug) then {
        ["[fn_garrison_onGarrisoningSpawnResources] Already spawned: [_spawnResources, _targetClassNames]: %1"
            , str [_spawnResources, _targetClassNames], "GARRISON", true] call KPLIB_fnc_common_log;
    };
    _resources;
};

if (_debug) then {
    [format ["[fn_garrison_onGarrisonIntel] Creating: [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]: %1"
        , str [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_resources = _targetClassNames apply {
    private _spawnPos = [_markerPos, _x] call MFUNC(_getVehSpawnPos);
    [_x, _spawnPos, nil, _side] call KPLIB_fnc_resources_createCrate;
};

// Keep track of SPAWN RESOURCES condition, as well as the RESOURCE CLASS NAMES
_spawnResources = false;

{ _namespace setVariable _x; } forEach [
    [QMVAR(_resources), _resources]
    , [QMVAR(_spawnResources), _spawnResources]
    , [QMVAR(_spawnedResourceClassNames), _resources apply { typeOf _x; }]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnResources] Fini: [_markerName, markerText _markerName, count _targetClassNames, count _resources, _spawnResources]: %1"
        , str [_markerName, markerText _markerName, count _targetClassNames, count _resources, _spawnResources]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_resources;
