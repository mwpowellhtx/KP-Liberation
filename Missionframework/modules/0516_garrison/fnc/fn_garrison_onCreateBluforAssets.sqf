#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCreateBluforAssets

    File: fn_garrison_onCreateBluforAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 16:53:44
    Last Update: 2021-06-14 17:12:58
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

private _debug = MPARAM(_onCreateBluforAssets_debug)
    || (_sector getVariable [QMVAR(_onCreateBluforAssets_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_garrison_onCreateBluforAssets] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: ...

if (_debug) then {
    ["[fn_garrison_onCreateBluforAssets] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
