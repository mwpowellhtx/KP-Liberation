#include "script_component.hpp"
#include "defines.hpp"
#include "..\..\0228_resources\fnc\defines.hpp"
/*
    KPLIB_fnc_garrison_onAllocateOpforUnits

    File: fn_garrison_onAllocateOpforUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:33:46
    Last Update: 2021-06-14 17:13:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the UNITS ALLOCATION during the SECTOR ACTIVATION GARRISON
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
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_regimentMap), createHashMap, [emptyHashMap]]
];

private _debug = MPARAM(_onAllocateOpforUnits_debug)
    || (_sector getVariable [QMVAR(_onAllocateOpforUnits_debug), false]);

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _ratioBundle = _regimentMap get QMVAR(_ratioBundle);

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforUnits] Entering: [_markerName, markerText _markerName, _sectorType]: %1"
        , str [_markerName, markerText _markerName, _sectorType]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_ratioBundle params [
    [Q(_0), 0, [0]]
    , [Q(_opforStrengthRatio), 0, [0]]
    , [Q(_opforAwarenessRatio), 0, [0]]
    , [Q(_bluforStrengtRatio), 0, [0]]
];

// Values are defaulted to empty string (i.e. "") via PREPROCESSOR MACRO
[
    1 - _opforAwarenessRatio
    , _bluforStrengtRatio * _opforStrengthRatio
    // UNIT
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_OFFSETS,_sectorType)
] params [
    Q(_inverseOpforAwarenessRatio)
    , Q(_adjustedOpforStrengthRatio)
    , Q(_dieSides)
    , Q(_dieTimes)
    , Q(_dieOffsets)
];

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforUnits] Components: [_dieSides, _dieTimes, _dieOffsets, _inverseOpforAwarenessRatio, _adjustedOpforStrengthRatio]: %1"
        , str [_dieSides, _dieTimes, _dieOffsets, _inverseOpforAwarenessRatio, _adjustedOpforStrengthRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// With roll components influences by both OPFOR_STRENTGH/OPFOR_AWARENESS/CIVREP+BLUFOR_STRENGTH
private _dice = [
    [_dieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    , [_dieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    , true
    , [_dDieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
];

private _allocationCount = _dice call KPLIB_fnc_linq_roll;

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforUnits] Allocation: [_allocationCount, _dice]: %1"
        , str [_allocationCount, _dice]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _onAllocate = {
    private _allocation = [];
    _allocation resize _this;
    _allocation;
};

private _allocation = _allocationCount call _onAllocate;
_regimentMap set [QMVAR(_unitAllocation), _allocation];

if (_debug) then {
    [format ["[fn_garrison_onAllocateOpforUnits] Fini: [count _allocation]: %1"
        , str [count _allocation]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
