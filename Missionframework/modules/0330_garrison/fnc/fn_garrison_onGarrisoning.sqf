#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoning

    File: fn_garrison_onGarrisoning.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 16:33:22
    Last Update: 2021-04-16 16:43:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        What we populate the CBA GARRISON namespace with depends on ALIGNMENT,
        as well as AWARENESS, STRENGTH, and sometimes also CIVILIAN REPUTATION.

    Parameter(s):
        _namespace - a CBA GARRISON namespace [LOGATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

// TODO: TBD: currently assuming that the sector is "OPFOR" when it requires GARRISON
// TODO: TBD: may also garrison for BLUFOR, i.e. especially for CR hostile scenarios...
// TODO: TBD: i.e. garrison of IEDs, but then again...
// TODO: TBD: i.e. may need to add constraints when objects already exist...
// TODO: TBD: i.e. which also beggars the question, should "all" sectors just be wrapped in a namespace to begin with
// TODO: TBD: strong likelihood that yes, we should...
private _debug = MPARAM(_onGarrisoning_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Entering: [isNull _namespace]: %1"
        , str [isNull _namespace]], "GARRISON", true] call KPLIB_fnc_common_log;
};

[
    [_namespace, KPLIB_sectors_status_garrisoning, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
    , _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_blufor), false]
    , _namespace getVariable [Q(KPLIB_sectors_opfor), false]
] params [
    Q(_garrisoning)
    , Q(_markerName)
    , Q(_blufor)
    , Q(_opfor)
];

// Preclude this from happening when CBA SECTOR namespace GARRISON has already happened
if (isNull _namespace || _garrisoning) exitWith {
    false;
};

private _getSectorSide = {
    private _candidates = _this;
    private _sides = _candidates select { (_x#0); } apply { (_x#1); };
    (_sides#0);
};

// TODO: TBD: sideEmpty? or resistance? or just friendly?
private _side = [
    [_blufor, KPLIB_preset_sideF]
    , [_opfor, KPLIB_preset_sideE]
    , [true, sideEmpty]
] call _getSectorSide;

_namespace setVariable [Q(KPLIB_sectors_side), _side];

private _markerPrefix = _markerName select [
    0
    , (count _markerName) min (count KPLIB_eden_prefix_metropolis)
];

// APC LIGHT VEHICLES may be included for these markers
private _lightVehicleApcs = _markerPrefix in [
    KPLIB_eden_prefix_factory
    , KPLIB_eden_prefix_city
    , KPLIB_eden_prefix_metropolis
];

// By default, no INTEL, nor IEDs, is to be specified
private _intelArgs = [];
private _iedArgs = [];

// TODO: TBD: needs to take into account: SIDE for the auto-spec...
// TODO: TBD: maybe sketch in whether to do so for BLUFOR as well...
// TODO: TBD: may spec IED no matter what
// TODO: TBD: also MUST consider appropriate strength numbers, taking in to account STRENGTH, PLAYER STRENGTH, as well as CIVREP
// TODO: TBD: considering these I think will "get us there" or at least in a stronger position to begin reconsidering the whole sector activation issue
// TODO: TBD: by that I mean activating sectors for side player, but also when BLUFOR must 'defend' a sector, then 'player garrison' may kick in
// TODO: TBD: which player garrison is planned for after activation
private _args = switch (true) do {
    case (_side == KPLIB_preset_sideE && _markerPrefix == KPLIB_eden_prefix_base): {
        // Only specify INTEL for BASE sectors, bit of overlap here with RESOURCES module, but this is GARRISON specific
        _intelArgs = [MPARAM(_baseIntelMin), MPARAM(_baseIntelCount), MPARAM(_baseIntelCeil), MPARAM(_baseIntelCoef)] call MFUNC(_onGarrisoningMakeIntelArgs);
        // TODO: TBD: so far so good...
        // TODO: TBD: should we also relay bias, threshold, etc?
        [
            [MPARAM(_baseGrpMin), MPARAM(_baseGrpCount), MPARAM(_baseGrpCeil)]
            , [MPARAM(_baseUnitMin), MPARAM(_baseUnitCount), MPARAM(_baseUnitCeil), MPARAM(_baseUnitCoef)]
            , [MPARAM(_baseLightVehicleMin), MPARAM(_baseLightVehicleCount), MPARAM(_baseLightVehicleCeil), MPARAM(_baseLightVehicleCoef)]
            , [MPARAM(_baseHeavyVehicleMin), MPARAM(_baseHeavyVehicleCount), MPARAM(_baseHeavyVehicleCeil), MPARAM(_baseHeavyVehicleCoef)]
        ];
    };
    case (_side == KPLIB_preset_sideE && _markerPrefix == KPLIB_eden_prefix_factory): {
        _iedArgs = [MPARAM(_factoryIedMin), MPARAM(_factoryIedCount), MPARAM(_factoryIedCeil), MPARAM(_factoryIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [
            [MPARAM(_factoryGrpMin), MPARAM(_factoryGrpCount), MPARAM(_factoryGrpCeil)]
            , [MPARAM(_factoryUnitMin), MPARAM(_factoryUnitCount), MPARAM(_factoryUnitCeil), MPARAM(_factoryUnitCoef)]
            , [MPARAM(_factoryLightVehicleMin), MPARAM(_factoryLightVehicleCount), MPARAM(_factoryLightVehicleCeil), MPARAM(_factoryLightVehicleCoef)]
            , [MPARAM(_factoryHeavyVehicleMin), MPARAM(_factoryHeavyVehicleCount), MPARAM(_factoryHeavyVehicleCeil), MPARAM(_factoryHeavyVehicleCoef)]
        ];
    };
    case (_side == KPLIB_preset_sideE && _markerPrefix == KPLIB_eden_prefix_city): {
        _iedArgs = [MPARAM(_cityIedMin), MPARAM(_cityIedCount), MPARAM(_cityIedCeil), MPARAM(_cityIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [
            [MPARAM(_cityGrpMin), MPARAM(_cityGrpCount), MPARAM(_cityGrpCeil)]
            , [MPARAM(_cityUnitMin), MPARAM(_cityUnitCount), MPARAM(_cityUnitCeil), MPARAM(_cityUnitCoef)]
            , [MPARAM(_cityLightVehicleMin), MPARAM(_cityLightVehicleCount), MPARAM(_cityLightVehicleCeil), MPARAM(_cityLightVehicleCoef)]
            , [MPARAM(_cityHeavyVehicleMin), MPARAM(_cityHeavyVehicleCount), MPARAM(_cityHeavyVehicleCeil), MPARAM(_cityHeavyVehicleCoef)]
        ];
    };
    case (_side == KPLIB_preset_sideE && _markerPrefix == KPLIB_eden_prefix_metropolis): {
        _iedArgs = [MPARAM(_metropolisIedMin), MPARAM(_metropolisIedCount), MPARAM(_metropolisIedCeil), MPARAM(_metropolisIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [
            [MPARAM(_metropolisGrpMin), MPARAM(_metropolisGrpCount), MPARAM(_metropolisGrpCeil)]
            , [MPARAM(_metropolisUnitMin), MPARAM(_metropolisUnitCount), MPARAM(_metropolisUnitCeil), MPARAM(_metropolisUnitCoef)]
            , [MPARAM(_metropolisLightVehicleMin), MPARAM(_metropolisLightVehicleCount), MPARAM(_metropolisLightVehicleCeil), MPARAM(_metropolisLightVehicleCoef)]
            , [MPARAM(_metropolisHeavyVehicleMin), MPARAM(_metropolisHeavyVehicleCount), MPARAM(_metropolisHeavyVehicleCeil), MPARAM(_metropolisHeavyVehicleCoef)]
        ];
    };
    case (_side == KPLIB_preset_sideE && _markerPrefix == KPLIB_eden_prefix_tower): {
        [
            [MPARAM(_towerGrpMin), MPARAM(_towerGrpCount), MPARAM(_towerGrpCeil)]
            , [MPARAM(_towerUnitMin), MPARAM(_towerUnitCount), MPARAM(_towerUnitCeil), MPARAM(_towerUnitCoef)]
            , [MPARAM(_towerLightVehicleMin), MPARAM(_towerLightVehicleCount), MPARAM(_towerLightVehicleCeil), MPARAM(_towerLightVehicleCoef)]
            , [MPARAM(_towerHeavyVehicleMin), MPARAM(_towerHeavyVehicleCount), MPARAM(_towerHeavyVehicleCeil), MPARAM(_towerHeavyVehicleCoef)]
        ];
    };
    // SECTOR already BLUFOR, so we do not want to re-GARRISON, apart from a possibility for IEDs
    case (_side == KPLIB_preset_sideF && _markerPrefix == KPLIB_eden_prefix_factory): {
        _iedArgs = [MPARAM(_factoryIedMin), MPARAM(_factoryIedCount), MPARAM(_factoryIedCeil), MPARAM(_factoryIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [];
    };
    case (_side == KPLIB_preset_sideF && _markerPrefix == KPLIB_eden_prefix_city): {
        _iedArgs = [MPARAM(_cityIedMin), MPARAM(_cityIedCount), MPARAM(_cityIedCeil), MPARAM(_cityIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [];
    };
    case (_side == KPLIB_preset_sideF && _markerPrefix == KPLIB_eden_prefix_metropolis): {
        _iedArgs = [MPARAM(_metropolisIedMin), MPARAM(_metropolisIedCount), MPARAM(_metropolisIedCeil), MPARAM(_metropolisIedCoef)] call MFUNC(_onGarrisoningMakeIedArgs);
        [];
    };
    default {
        // Likewise, similarly, BLUFOR military bases should not receive INTEL once again
        [];
    };
};

// TODO: TBD: throttle the counts according to ENEMY STRENGTH and CIVILIAN REPUTATION...

// De-con the GARRISON SPECS, then identify the LIGHT and HEAVY VEHICLE components of the garrison
private _garrisonSpecs = _args call MFUNC(_onGarrisoningCalculateCounts);
_garrisonSpecs params [
    Q(_grpCount)
    , Q(_unitCount)
    , Q(_lightVehicleCount)
    , Q(_heavyVehicleCount)
];

// Careful here to make a copy of the presets
private _lightVehicleClassNames = [_lightVehicleCount, +KPLIB_preset_vehLightArmedPlE, _lightVehicleApcs] call {
    params [
        [Q(_count), 0, [0]]
        , [Q(_presets), [], [[]]]
        , [Q(_apcs), false, [false]]
    ];
    if (_apcs) then {
        _presets append KPLIB_preset_vehHeavyApcPlE;
    };
    private _classNames = [];
    _classNames resize _count;
    _classNames apply { selectRandom _presets; }
};

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Heavy vehicles: [count _lightVehicleClassNames, _lightVehicleClassNames]: %1"
        , str [count _lightVehicleClassNames, _lightVehicleClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _heavyVehicleClassNames = [_heavyVehicleCount, KPLIB_preset_vehHeavyApcPlE + KPLIB_preset_vehHeavyPlE] call {
    params [
        [Q(_count), 0, [0]]
        , [Q(_presets), [], [[]]]
    ];
    private _classNames = [];
    _classNames resize _count;
    _classNames apply { selectRandom _presets; }
};

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Heavy vehicles: [count _heavyVehicleClassNames, _heavyVehicleClassNames]: %1"
        , str [count _heavyVehicleClassNames, _heavyVehicleClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// We let the args pass through, empty or defaults should yield empty class names array
private _iedClassNames = _iedArgs call MFUNC(_onGarrisoningCalculateBits);

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Intel: [_iedArgs, _iedClassNames]: %1"
        , str [_iedArgs, _iedClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _intelClassNames = _intelArgs call MFUNC(_onGarrisoningCalculateBits);

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Intel: [_intelArgs, _intelClassNames]: %1"
        , str [_intelArgs, _intelClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

{ _namespace setVariable _x; } forEach [
    [QMVAR(_grpCount), _grpCount]
    , [QMVAR(_unitCount), _unitCount]
    , [QMVAR(_lightVehicleCount), _lightVehicleCount]
    , [QMVAR(_heavyVehicleCount), _heavyVehicleCount]
    , [QMVAR(_lightVehicleClassNames), _lightVehicleClassNames]
    , [QMVAR(_heavyVehicleClassNames), _heavyVehicleClassNames]
    , [QMVAR(_iedClassNames), _iedClassNames]
    , [QMVAR(_intelClassNames), _intelClassNames]
];

if (_debug) then {
    ["[fn_garrison_onGarrisoning] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
