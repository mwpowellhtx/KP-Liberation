#include "script_component.hpp"
#include "defines.hpp"
#include "..\..\0228_resources\fnc\defines.hpp"
/*
    KPLIB_fnc_garrison_onAllocateResources

    File: fn_garrison_onAllocateResources.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:33:46
    Last Update: 2021-06-24 12:46:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the RESOURCES ALLOCATION during the SECTOR ACTIVATION GARRISON
        phase. This happens only one time for RESOURCES.

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

// One and only one time evaluation
if (QMVAR(_resourceAllocation) in _regimentMap) exitWith { true; };

private _debug = MPARAM(_onAllocateResources_debug)
    || (_sector getVariable [QMVAR(_onAllocateResources_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _ratioBundle = _sector getVariable [QMVAR(_ratioBundle), []];

_ratioBundle params [
    [Q(_civRepRatio), 0, [0]]
];

if (_debug) then {
    [format ["[fn_garrison_onAllocateResources] Entering: [_markerName, markerText _markerName, _sectorType, _civRepRatio]: %1"
        , str [_markerName, markerText _markerName, _sectorType, _civRepRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Values are defaulted to empty string (i.e. "") via PREPROCESSOR MACRO
[
    SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_OFFSETS,_sectorType)
    , SECTORTYPE_PARAM_DEF(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_BIAS,_sectorType,0)
] params [
    Q(_dieSides)
    , Q(_dieTimes)
    , Q(_dieOffsets)
    , Q(_bias)
];

private _adjustedCivRepRatio = _civRepRatio + PCT(_bias);

if (_debug) then {
    [format ["[fn_garrison_onAllocateResources] Components: [_dieSides, _dieTimes, _dieOffsets, _bias, _adjustedCivRepRatio]: %1"
        , str [_dieSides, _dieTimes, _dieOffsets, _bias, _adjustedCivRepRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// With roll components influences by both OPFOR_STRENTGH/OPFOR_AWARENESS/CIVREP+BLUFOR_STRENGTH
private _dice = [
    [_dieSides, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    , [_dieTimes, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    , true
    , [_dieOffsets, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
];

private _allocationCount = _dice call KPLIB_fnc_linq_heroSystemBodyRoll;

if (_debug) then {
    [format ["[fn_garrison_onAllocateResources] Allocation: [_allocationCount, _dice]: %1"
        , str [_allocationCount, _dice]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _onAllocate = {
    private _allocation = [];
    _allocation resize _this;
    _allocation;
};

private _allocation = _allocationCount call _onAllocate;
_regimentMap set [QMVAR(_resourceAllocation), _allocation];

if (_debug) then {
    [format ["[fn_garrison_onAllocateResources] Fini: [count _allocation]: %1"
        , str [count _allocation]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
