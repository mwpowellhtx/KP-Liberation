#include "script_component.hpp"
#include "defines.hpp"
#include "..\..\0228_resources\fnc\defines.hpp"
/*
    KPLIB_fnc_garrison_getOpforSectorCounts

    File: fn_garrison_getOpforSectorCounts.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:33:46
    Last Update: 2021-05-05 15:32:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns several counts that inform a OPFOR SECTOR garrison.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The OPFOR SECTOR counts [ARRAY]
            [
                _unitCount
                , _grpCount
                , _lightVehicleCount
                , _heavyVehicleCount
                , _intelCount
                , _iedCount
                , _resourceCount
            ]

    Remarks:
        REGEX support would be incredibly useful for sector use cases. But unfortunately
        this is DEV BRANCH ONLY right now. Truly a shame that A3 has been around so long
        and has never seen REGEX support.

    References:
        https://community.bistudio.com/wiki/find
        https://community.bistudio.com/wiki/Category:Command_Group:_Regular_Expression_(Regex)
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_getOpforSectorCounts_debug)
    || (_namespace getVariable [QMVAR(_getOpforSectorCounts_debug), false]);

private _markerName = _namespace getVariable [Q(KPLIB_sectors_markerName), ""];
private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _markerPrefix = format ["KPLIB_eden_%1", _sectorType];

if (_debug) then {
    [format ["[fn_garrison_getOpforSectorCounts] Entering: [_markerName, markerText _markerName, _sectorType, _markerPrefix]: %1"
        , str [_markerName, markerText _markerName, _sectorType, _markerPrefix]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Verify the SECTOR TYPE as a precaution
if (_markerName in KPLIB_sectors_blufor || _markerName find _markerPrefix < 0) exitWith {
    if (_debug) then {
        [format ["[fn_garrison_getOpforSectorCounts] BLUFOR|PREFIX: [_markerName, markerText _markerName, _markerPrefix]: %1"
            , str [_markerName, markerText _markerName, _markerPrefix]], "GARRISON", true] call KPLIB_fnc_common_log;
    };
    [];
};

([] call MFUNC(_getRatioBundle)) params [
    [Q(_civRepRatio), 0, [0]]
    , [Q(_opforStrengthRatio), 0, [0]]
    , [Q(_opforAwarenessRatio), 0, [0]]
    , [Q(_bluforStrengtRatio), 0, [0]]
];

if (_debug) then {
    [format ["[fn_garrison_getOpforSectorCounts] Ratios: [_markerName, markerText _markerName, _civRepRatio, _opforStrengthRatio, _opforAwarenessRatio, _bluforStrengtRatio]: %1"
        , str [_markerName, markerText _markerName, _civRepRatio, _opforStrengthRatio, _opforAwarenessRatio, _bluforStrengtRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Values are defaulted to empty string (i.e. "") via PREPROCESSOR MACRO
[
    1 - _opforAwarenessRatio
    , abs (0 min _civRepRatio)
    // UNIT
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_OFFSETS,_sectorType)
    // GRP
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_OFFSETS,_sectorType)
    // LIGHT VEHICLE
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_OFFSETS,_sectorType)
    // HEAVY VEHICLE
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_OFFSETS,_sectorType)
    // INTEL
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_OFFSETS,_sectorType)
    // IED
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_OFFSETS,_sectorType)
    // RESOURCE
    , SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_SIDES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_TIMES,_sectorType)
    , SECTORTYPE_PARAM(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_OFFSETS,_sectorType)
    , SECTORTYPE_PARAM_DEF(KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_BIAS,_sectorType,0)
] params [
    Q(_inverseOpforAwarenessRatio)
    , Q(_hostileCivRepRatio)
    , Q(_unitDieSides)
    , Q(_unitDieTimes)
    , Q(_unitDieOffsets)
    , Q(_grpDieSides)
    , Q(_grpDieTimes)
    , Q(_grpDieOffsets)
    , Q(_lightVehicleDieSides)
    , Q(_lightVehicleDieTimes)
    , Q(_lightVehicleDieOffsets)
    , Q(_heavyVehicleDieSides)
    , Q(_heavyVehicleDieTimes)
    , Q(_heavyVehicleDieOffsets)
    , Q(_intelDieSides)
    , Q(_intelDieTimes)
    , Q(_intelDieOffsets)
    , Q(_iedDieSides)
    , Q(_iedDieTimes)
    , Q(_iedDieOffsets)
    , Q(_resourceDieSides)
    , Q(_resourceDieTimes)
    , Q(_resourceDieOffsets)
    , Q(_resourceBias)
];

if (_debug) then {
    [format ["[fn_garrison_getOpforSectorCounts] More ratios: [_markerName, markerText _markerName, _inverseOpforAwarenessRatio, _hostileCivRepRatio]: %1"
        , str [_markerName, markerText _markerName, _inverseOpforAwarenessRatio, _hostileCivRepRatio]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _unitDieSides, _unitDieTimes, _unitDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _unitDieSides, _unitDieTimes, _unitDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _grpDieSides, _grpDieTimes, _grpDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _grpDieSides, _grpDieTimes, _grpDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _lightVehicleDieSides, _lightVehicleDieTimes, _lightVehicleDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _lightVehicleDieSides, _lightVehicleDieTimes, _lightVehicleDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _heavyVehicleDieSides, _heavyVehicleDieTimes, _heavyVehicleDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _heavyVehicleDieSides, _heavyVehicleDieTimes, _heavyVehicleDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _intelDieSides, _intelDieTimes, _intelDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _intelDieSides, _intelDieTimes, _intelDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _iedDieSides, _iedDieTimes, _iedDieOffsets]: %1"
        , str [_markerName, markerText _markerName, _iedDieSides, _iedDieTimes, _iedDieOffsets]], "GARRISON", true] call KPLIB_fnc_common_log;

    [format ["[fn_garrison_getOpforSectorCounts] Components: [_markerName, markerText _markerName, _resourceDieSides, _resourceDieTimes, _resourceDieOffsets, _resourceBias]: %1"
        , str [_markerName, markerText _markerName, _resourceDieSides, _resourceDieTimes, _resourceDieOffsets, _resourceBias]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _sum = true;

[
    _bluforStrengtRatio * _opforStrengthRatio
    , _bluforStrengtRatio * _inverseOpforAwarenessRatio
    , _civRepRatio + PCT(_resourceBias)
] params [
    Q(_adjustedOpforStrengthRatio)
    , Q(_adjustedOpforAwarenessRatio)
    , Q(_adjustedCivRepRatio)
];

// With roll components influences by both OPFOR_STRENTGH/OPFOR_AWARENESS/CIVREP+BLUFOR_STRENGTH
[
    [
        [_unitDieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_unitDieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_unitDieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_grpDieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_grpDieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_grpDieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_lightVehicleDieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_lightVehicleDieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_lightVehicleDieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_heavyVehicleDieSides, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_heavyVehicleDieTimes, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_heavyVehicleDieOffsets, _adjustedOpforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_intelDieSides, _adjustedOpforAwarenessRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_intelDieTimes, _adjustedOpforAwarenessRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_intelDieOffsets, _adjustedOpforAwarenessRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_iedDieSides, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_iedDieTimes, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_iedDieOffsets, _hostileCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
    , [
        [_resourceDieSides, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
        , [_resourceDieTimes, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
        , _sum
        , [_resourceDieOffsets, _adjustedCivRepRatio] call KPLIB_fnc_core_getIndexedNumber
    ]
] params [
    Q(_unitDice)
    , Q(_grpDice)
    , Q(_lightVehicleDice)
    , Q(_heavyVehicleDice)
    , Q(_intelDice)
    , Q(_iedDice)
    , Q(_resourceDice)
];

if (_debug) then {
    [format ["[fn_garrison_getOpforSectorCounts] Dice: [_markerName, markerText _markerName, _unitDice, _grpDice, _lightVehicleDice, _heavyVehicleDice, _intelDice, _iedDice, _resourceDice]: %1"
        , str [_markerName, markerText _markerName, _unitDice, _grpDice, _lightVehicleDice, _heavyVehicleDice, _intelDice, _iedDice, _resourceDice]], "GARRISON", true] call KPLIB_fnc_common_log;
};

[
    _unitDice call KPLIB_fnc_linq_roll
    , _grpDice call KPLIB_fnc_linq_heroSystemKillingRoll
    , _lightVehicleDice call KPLIB_fnc_linq_heroSystemKillingRoll
    , _heavyVehicleDice call KPLIB_fnc_linq_heroSystemKillingRoll
    , _intelDice call KPLIB_fnc_linq_heroSystemKillingRoll
    , _iedDice call KPLIB_fnc_linq_heroSystemKillingRoll
    , _resourceDice call KPLIB_fnc_linq_heroSystemKillingRoll
] params [
    Q(_unitCount)
    , Q(_grpCount)
    , Q(_lightVehicleCount)
    , Q(_heavyVehicleCount)
    , Q(_intelCount)
    , Q(_iedCount)
    , Q(_resourceCount)
];

// At least ONE GRP
private _retval = [
    _unitCount
    , _grpCount max 1
    , _lightVehicleCount
    , _heavyVehicleCount
    , _intelCount
    , _iedCount
    , _resourceCount
];

if (_debug) then {
    [format ["[fn_garrison_getOpforSectorCounts] Fini: [_markerName, markerText _markerName, _unitCount, _grpCount, _lightVehicleCount, _heavyVehicleCount, _intelCount, _iedCount, _resourceCount]: %1"
        , str [_markerName, markerText _markerName, _unitCount, _grpCount, _lightVehicleCount, _heavyVehicleCount, _intelCount, _iedCount, _resourceCount]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_retval;
