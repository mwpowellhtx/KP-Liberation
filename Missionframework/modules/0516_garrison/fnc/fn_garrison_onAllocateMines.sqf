#include "script_component.hpp"
#include "defines.hpp"
#include "..\..\0228_resources\fnc\defines.hpp"
/*
    KPLIB_fnc_garrison_onAllocateMines

    File: fn_garrison_onAllocateMines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:33:46
    Last Update: 2021-06-14 17:13:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the MINES (i.e. IED) ALLOCATION during the SECTOR ACTIVATION GARRISON
        phase. This happens only one time.

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

// Allocate mines (IED) once and once only for each CBA SECTOR namespace
if (QMVAR(_mineAllocation) in _regimentMap) exitWith { true; };

private _debug = MPARAM(_onAllocateMines_debug)
    || (_sector getVariable [QMVAR(_onAllocateMines_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _ratioBundle = _regimentMap get QMVAR(_ratioBundle);

if (_debug) then {
    [format ["[fn_garrison_onAllocateMines] Entering: [_markerName, markerText _markerName, _sectorType]: %1"
        , str [_markerName, markerText _markerName, _sectorType]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_ratioBundle params [
    [Q(_civRepRatio), 0, [0]]
    , [Q(_1), 0, [0]]
    , [Q(_2), 0, [0]]
    , [Q(_bluforStrengthRatio), 0, [0]]
];

// Values are defaulted to empty string (i.e. "") via PREPROCESSOR MACRO
[
    abs (0 min _civRepRatio)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_MINE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_MINE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_MINE_DIE_OFFSETS,_sectorType)
] params [
    Q(_hostileCivRepRatio)
    , Q(_dieSides)
    , Q(_dieTimes)
    , Q(_dieOffsets)
];

private _adjustedCivRepRatio = _bluforStrengthRatio * _hostileCivRepRatio;

if (_debug) then {
    [format ["[fn_garrison_onAllocateMines] Components: [_dieSides, _dieTimes, _dieOffsets, _hostileCivRepRatio, _adjustedCivRepRatio]: %1"
        , str [_dieSides, _dieTimes, _dieOffsets, _hostileCivRepRatio, _adjustedCivRepRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// With roll components influences by both OPFOR_STRENTGH/OPFOR_AWARENESS/CIVREP+BLUFOR_STRENGTH
private _dice = [
    [_dieSides, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    , [_dieTimes, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    , true
    , [_dieOffsets, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
];

private _allocationCount = _dice call KPLIB_fnc_linq_heroSystemBodyRoll;

if (_debug) then {
    [format ["[fn_garrison_onAllocateMines] Allocation: [_allocationCount, _dice]: %1"
        , str [_allocationCount, _dice]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: factor in CIVREP HOSTILITY in terms of a threshold/throttle selecting the IED classes...
private _onAllocate = {
    private _allocation = [];
    _allocation resize _this;
    _allocation apply { _adjustedCivRepRatio; };
};

// Only respond with those that have ANY chance of yielding a MINE (IED)
private _allocation = _allocationCount call _onAllocate;
_regimentMap set [QMVAR(_mineAllocation), _allocation select { _x > 0; }];

if (_debug) then {
    ["[fn_garrison_onAllocateMines] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
