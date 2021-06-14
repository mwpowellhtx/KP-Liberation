#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCreateResources

    File: fn_garrison_onCreateResources.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 16:53:34
    Last Update: 2021-06-14 17:12:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _regimentMap - the REGIMENT HASHMAP [HASHMAP, default: emptyHashMap]
        _garrisonMap - the GARRISON HASHMAP [HASHMAP, default: emptyHashMap]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_regimentMap), createHashMap, [emptyHashMap]]
    , [Q(_garrisonMap), createHashMap, [emptyHashMap]]
];

private _debug = MPARAM(_onCreateResources_debug)
    || (_sector getVariable [QMVAR(_onCreateResources_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _resources = _garrisonMap get QMVAR(_resources);

if (_debug) then {
    [format ["[fn_garrison_onCreateResources] Entering: [_markerName, markerText _markerName, isNil '_resources']: %1"
        , str [_markerName, markerText _markerName, isNil {_resources}]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if (!isNil { _resources; }) exitWith { true; };

private _sectorPos = position _sector;
private _side = [_sector] call KPLIB_fnc_sectors_getSide;
private _resourceClasses = _regimentMap get QMVAR(_resourceClasses);

_resources = _resourceClasses apply {
    private _vehiclePos = [_sectorPos, _x] call MFUNC(_getVehiclePosition);
    [_x, _vehiclePos, nil, _side] call KPLIB_fnc_resources_createCrate;
};

_garrisonMap set [QMVAR(_resources), _resources];

if (_debug) then {
    ["[fn_garrison_onCreateResources] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
