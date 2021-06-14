#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCreateOpforIntel

    File: fn_garrison_onCreateOpforIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 16:53:34
    Last Update: 2021-06-14 17:12:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates the INTEL objects for the CBA SECTOR namespace once and once only.
        Corresponds to MILITARY BASE sectors, and only spawns as many objects which
        fulfill both the number of regimented CLASS NAMES aligned with the random
        BUILDING POSITIONS as discovered in the sector.

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

private _debug = MPARAM(_onCreateOpforIntel_debug)
    || (_sector getVariable [QMVAR(_onCreateOpforIntel_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _intel = _garrisonMap get QMVAR(_intel);

if (_debug) then {
    [format ["[fn_garrison_onCreateOpforIntel] Entering: [_markerName, markerText _markerName, isNil '_intel']: %1"
        , str [_markerName, markerText _markerName, isNil {_intel}]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if (!isNil { _intel; }) exitWith { true; };

private _intelClasses = _regimentMap get QMVAR(_intelClasses);

// Randomly place each of the INTEL objects
private _buildings = _sector getVariable [QMVAR(_buildings), []];
private _positions = [_buildings] call MFUNC(_getBuildingPositions);

_intel = _intelClasses apply {
    private _obj = objNull;
    if (_positions isNotEqualTo []) then {
        private _targetPos = _positions deleteAt 0;
        _obj = [_x, _targetPos] call KPLIB_fnc_resources_createIntel;
    };
    _obj;
};

// Filter out the NULL ones
_garrisonMap set [QMVAR(_intel), _intel select { !isNull _x; }];
//                                               ^^^^^^^^^^

if (_debug) then {
    ["[fn_garrison_onCreateOpforIntel] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
