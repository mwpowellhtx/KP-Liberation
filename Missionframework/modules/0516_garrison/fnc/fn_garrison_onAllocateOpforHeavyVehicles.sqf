#include "script_component.hpp"
#include "defines.hpp"
#include "..\..\0228_resources\fnc\defines.hpp"
/*
    KPLIB_fnc_garrison_onAllocateOpforHeavyVehicles

    File: fn_garrison_onAllocateOpforHeavyVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:33:46
    Last Update: 2021-06-14 17:13:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the HEAVY VEHICLES ALLOCATION during the SECTOR ACTIVATION GARRISON
        phase.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _regimentMap - a REGIMENT HASHMAP [HASHMAP, default: createHashMap]

    Returns:
        The event handler has finished [BOOL]

    Remarks:
        REGEX support would be incredibly useful for sector use cases. But unfortunately
        this is DEV BRANCH ONLY right now. Truly a shame that A3 has been around so long
        and has never seen REGEX support.

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/merge
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_regimentMap), createHashMap, [emptyHashMap]]
];

private _debug = MPARAM(_onAllocateOpforHeavyVehicles_debug)
    || (_sector getVariable [QMVAR(_onAllocateOpforHeavyVehicles_debug), false]);

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _ratioBundle = _regimentMap get QMVAR(_ratioBundle);

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforHeavyVehicles] Entering: [_markerName, markerText _markerName, _sectorType]: %1"
        , str [_markerName, markerText _markerName, _sectorType]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_ratioBundle params [
    [Q(_0), 0, [0]]
    , [Q(_opforStrengthRatio), 0, [0]]
    , [Q(_2), 0, [0]]
    , [Q(_bluforStrengtRatio), 0, [0]]
];

// Values are defaulted to empty string (i.e. "") via PREPROCESSOR MACRO
[
    SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_OFFSETS,_sectorType)
] params [
    Q(_dieSides)
    , Q(_dieTimes)
    , Q(_dieOffsets)
];

private _adjustedOpforStrengthRatio = _bluforStrengtRatio * _opforStrengthRatio;

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforHeavyVehicles] Components: [_dieSides, _dieTimes, _dieOffsets, _adjustedOpforStrengthRatio]: %1"
        , str [_dieSides, _dieTimes, _dieOffsets, _adjustedOpforStrengthRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// With roll components influences by both OPFOR_STRENTGH/OPFOR_AWARENESS/CIVREP+BLUFOR_STRENGTH
private _dice = [
    [_dieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    , [_dieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    , true
    , [_dieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
];

private _allocationCount = _dice call KPLIB_fnc_linq_heroSystemBodyRoll;

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforHeavyVehicles] Allocation: [_allocationCount, _dice]: %1"
        , str [_allocationCount, _dice]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _onAllocate = {
    private _allocation = [];
    _allocation resize _this;
    _allocation;
};

private _allocation = _allocationCount call _onAllocate;
_regimentMap set [QMVAR(_heavyVehicleAllocation), _allocation];

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforHeavyVehicles] Fini: [count _allocation]: %1"
        , str [count _allocation]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
