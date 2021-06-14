#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCreateOpforAssets

    File: fn_garrison_onCreateOpforAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 16:53:34
    Last Update: 2021-06-14 17:12:50
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

private _debug = MPARAM(_onCreateOpforAssets_debug)
    || (_sector getVariable [QMVAR(_onCreateOpforAssets_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_garrison_onCreateOpforAssets] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _allClasses = [QMVAR(_lightVehicleClasses), QMVAR(_heavyVehicleClasses)] apply {
    _regimentMap getOrDefault [_x, []];
};

private _justSpawn = true;
private _withCrew = true;

// TODO: TBD: may also consider expanding that to some fraction of ACTIVATION RANGE...
private _assets = (flatten _allClasses) apply {
    private _vehiclePos = [_sectorPos, _x] call MFUNC(_getVehiclePosition);
    [_x, _vehiclePos, random 360, _justSpawn, _withCrew] call KPLIB_fnc_common_createVehicle;
};

private _units = _garrisonMap getOrDefault [QMVAR(_units), []];
private _assetCrew = flatten (_assets apply { crew _x; });
_units append _assetCrew;

{ _garrisonMap set _x; } forEach [
    [QMVAR(_units), _units]
    , [QMVAR(_assets), _assets]
];

if (_debug) then {
    [format ["[fn_garrison_onCreateOpforAssets] Fini: [count _assets, count _units, count _assetCrew]"
        , str [count _assets, count _units, count _assetCrew]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
