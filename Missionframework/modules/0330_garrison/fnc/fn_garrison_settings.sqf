#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_garrison_settings

    File: fn_garrison_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 21:47:20
    Last Update: 2021-05-05 14:25:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

// This bundles several of the cross-cutting GARRISON CBA settings across SECTOR TYPE vectors
{
    _x params [
        [Q(_sectorType), "", [""]]
        , [Q(_unitDieSides), "", [""]]
        , [Q(_unitDieTimes), "", [""]]
        , [Q(_unitDieOffsets), "", [""]]
        , [Q(_iedDieSides), "", [""]]
        , [Q(_iedDieTimes), "", [""]]
        , [Q(_iedDieOffsets), "", [""]]
        , [Q(_grpDieSides), "6,4,3", [""]]
        , [Q(_grpDieTimes), "1,2", [""]]
        , [Q(_grpDieOffsets), "1,2", [""]]
        , [Q(_lightVehicleDieSides), "10,8,6", [""]]
        , [Q(_lightVehicleDieTimes), "3,4", [""]]
        , [Q(_lightVehicleDieOffsets), "4,5", [""]]
        , [Q(_heavyVehicleDieSides), "12,10,8", [""]]
        , [Q(_heavyVehicleDieTimes), "2,3", [""]]
        , [Q(_heavyVehicleDieOffsets), "3,4", [""]]
    ];

    // MIN+MAX+GRPS+LIGHT+HEAVY+VEHICLES, inform a hard number, throttled by PLAYER+ENEMY+STRENGTH ratios
    private _categoryKey = format [KPLIB_GARRISON_SETTINGS_GARRISON_ENEMY_FORMAT, toUpper _sectorType];

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_SIDES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_UNIT_DIE_SIDES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _unitDieSides
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_TIMES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_UNIT_DIE_TIMES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _unitDieTimes
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_OFFSETS,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_UNIT_DIE_OFFSETS"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _unitDieOffsets
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_SIDES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_GRP_DIE_SIDES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _grpDieSides
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_TIMES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_GRP_DIE_TIMES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _grpDieTimes
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_OFFSETS,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_GRP_DIE_OFFSETS"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _grpDieOffsets
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_SIDES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_LIGHT_VEHICLE_DIE_SIDES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _lightVehicleDieSides
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_TIMES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_LIGHT_VEHICLE_DIE_TIMES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _lightVehicleDieTimes
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_OFFSETS,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_LIGHT_VEHICLE_DIE_OFFSETS"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _lightVehicleDieOffsets
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_SIDES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_HEAVY_VEHICLE_DIE_SIDES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _heavyVehicleDieSides
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_TIMES,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_HEAVY_VEHICLE_DIE_TIMES"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _heavyVehicleDieTimes
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_OFFSETS,_sectorType)
        , Q(EDITBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_HEAVY_VEHICLE_DIE_OFFSETS"
            , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_ENEMY_STRENGTH_TT"
        ]
        , localize _categoryKey
        , _heavyVehicleDieOffsets
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    // Not applicable when any one of the IED arguments is empty
    if (!(_iedDieSides isEqualTo "" || _iedDieTimes isEqualTo "" || _iedDieOffsets isEqualTo "")) then {
        [
            QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_SIDES,_sectorType)
            , Q(EDITBOX)
            , [
                localize "STR_KPLIB_SETTINGS_GARRISON_IED_DIE_SIDES"
                , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_NEGATIVE_CIV_REP_TT"
            ]
            , localize _categoryKey
            , _iedDieSides
            , 1
            , {}
        ] call CBA_fnc_addSetting;

        [
            QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_TIMES,_sectorType)
            , Q(EDITBOX)
            , [
                localize "STR_KPLIB_SETTINGS_GARRISON_IED_DIE_TIMES"
                , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_NEGATIVE_CIV_REP_TT"
            ]
            , localize _categoryKey
            , _iedDieTimes
            , 1
            , {}
        ] call CBA_fnc_addSetting;

        [
            QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_OFFSETS,_sectorType)
            , Q(EDITBOX)
            , [
                localize "STR_KPLIB_SETTINGS_GARRISON_IED_DIE_OFFSETS"
                , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_NEGATIVE_CIV_REP_TT"
            ]
            , localize _categoryKey
            , _iedDieOffsets
            , 1
            , {}
        ] call CBA_fnc_addSetting;
    };

} forEach [
    [Q(city), "10,8,6", "8,12,16", "2,3,4", "4,3", "2,3", "2,3,4"]
    , [Q(metropolis), "10,8,6", "8,12,16", "2,3,4", "5,4", "3,4", "3,4,5"]
    , [Q(factory), "10,8,6", "8,12,16", "2,3,4", "3,2", "2,3", "1,2,3"]
    , [Q(base), "10,8,6", "8,12,16", "2,3,4"]
    , [Q(tower), "10,8,6", "8,12,16", "2,3,4"]
];

// Another set of bundled cross-cutting GARRISON CBA settings
{
    _x params [
        [Q(_sectorType), "", [""]]
        , [Q(_defaultGarrisonApcs), false, [false]]
    ];

    // Supporting several SECTOR specific flags
    private _categoryKey = format [KPLIB_GARRISON_SETTINGS_GARRISON_ENEMY_FORMAT, toUpper _sectorType];

    [
        QSECTORTYPE_PARAM(KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GARRISON_APCS,_sectorType)
        , Q(CHECKBOX)
        , [
            localize "STR_KPLIB_SETTINGS_GARRISON_SECTOR_GARRISONS_APCS"
            , localize "STR_KPLIB_SETTINGS_GARRISON_SECTOR_GARRISONS_APCS_TT"
        ]
        , localize _categoryKey
        , _defaultGarrisonApcs
        , 1
        , {}
    ] call CBA_fnc_addSetting;

} forEach [
    [Q(city), true]
    , [Q(metropolis), true]
    , [Q(factory)]
    , [Q(base), true]
    , [Q(tower)]
];

// Plus a handful of INTEL bits
[
    QMPARAM(_baseIntelDieSides)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_DIE_SIDES"
        , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_INVERSE_ENEMY_AWARENESS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
    , "8,6,4"
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_baseIntelDieTimes)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_DIE_TIMES"
        , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_INVERSE_ENEMY_AWARENESS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
    , "4,3,2"
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_baseIntelDieOffsets)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_DIE_OFFSETS"
        , localize "STR_KPLIB_SETTINGS_GARRISON_DIE_BITS_INVERSE_ENEMY_AWARENESS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
    , "3,2,1"
    , 1
    , {}
] call CBA_fnc_addSetting;

// [
//     QMPARAM(_intelMin)
//     , Q(SLIDER)
//     , [
//         localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_MIN"
//         , localize "STR_KPLIB_SETTINGS_GARRISON_MIN_INVERSE_ENEMY_AWARENESS_TT"
//     ]
//     , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
//     , [0, 100, 20, 0] // range: [0, 100], default: 20
//     , 1
//     , {}
// ] call CBA_fnc_addSetting;

// [
//     QMPARAM(_intelMax)
//     , Q(SLIDER)
//     , [
//         localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_MAX"
//         , localize "STR_KPLIB_SETTINGS_GARRISON_MAX_INVERSE_ENEMY_AWARENESS_TT"
//     ]
//     , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
//     , [0, 100, 40, 0] // range: [0, 100], default: 40
//     , 1
//     , {}
// ] call CBA_fnc_addSetting;

[
    QMPARAM(_intelLockedVehicleCoef)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_LOCKED_COEF"
        , localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_LOCKED_COEF_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
    , [0, 200, 100, 0] // range: [0, 200], default: 100
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_intelBuildingDamageThreshold)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_BUILDING_DAMAGE_THRESHOLD"
        , localize "STR_KPLIB_SETTINGS_GARRISON_INTEL_BUILDING_DAMAGE_THRESHOLD_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_ENEMY_BASE"
    , [25, 75, 50, 0] // range: [25, 75], default: 50
    , 1
    , {}
] call CBA_fnc_addSetting;

// TODO: TBD: need to think through the whole BIAS question...
// TODO: TBD: i.e. is it a THROTTLE throttle?
// TODO: TBD: thinking "biases" more for mission spawns, i.e. garrison for missions like S+R, HTV, HVT, etc
// Also arrange for overall BIAS settings
[
    QMPARAM(_lightVehicleStrengthBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_LIGHT_VEHICLE"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 30, 0] // range: [0, 100], default: 30
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_heavyVehicleStrengthBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_HEAVY_VEHICLE"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 45, 0] // range: [0, 100], default: 45
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_rotaryStrengthBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_ROTARY"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 65, 0] // range: [0, 100], default: 65
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_fixedWingStrengthBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_FIXED_WING"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_STRENGTH_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 85, 0] // range: [0, 100], default: 85
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_unitCivRepBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_CIV_REP_UNIT"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_CIV_REP_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 40, 0] // range: [0, 100], default: 40
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_iedCivRepBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_CIV_REP_IED"
        , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS_CIV_REP_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GARRISON_BIAS"
    , [0, 100, 60, 0] // range: [0, 100], default: 60
    , 1
    , {}
] call CBA_fnc_addSetting;

// TODO: TBD: also pending, CBA settings 

if (isServer) then {
    
    MPARAM(_onLoadData_debug)                       = false;
    MPARAM(_onSaveData_debug)                       = false;
    MPARAM(_onGarrisoning_debug)                    = true;
    MPARAM(_onGarrisoningSpawnIntel_debug)          = true;
    MPARAM(_onGarrisoningCalculateBits_debug)       = false;
    MPARAM(_onSpawn_debug)                          = true;
    MPARAM(_onSpawnSectorInfantry_debug)            = true;
    MPARAM(_onSpawnSectorVehicle_debug)             = true;
    MPARAM(_onSpawnSectorResistance_debug)          = true;
    MPARAM(_getGarrison_debug)                      = false;
    MPARAM(_getOpforSectorCounts_debug)             = true;
    MPARAM(_getOpforGarrison_debug)                 = true;

    MPARAM(_defaultInfantryCount)                   =  6;

    // TODO: TBD: (re-)consider which incidental params should be proper CBA settings...
    // TODO: TBD: especially as we seek to address the garrison question by closing the gap
    // TODO: TBD: may defer some of these to actual CBA settings...
    MPARAM(_minRange)                               = 50;
    MPARAM(_nearEntityRange)                        = 20;
    MPARAM(_waypointCompletionRange)                = 30;

    MPARAM(_defendThreshold)                        =  3;
    MPARAM(_defendPatrolChance)                     = 25;
    MPARAM(_defendHoldChance)                       = 60;

    // Patrol chance used when creating units
    MPARAM(_patrolChance)                           = 15;
    MPARAM(_waypointCount)                          =  4;

    // Remember also the several IED thresholds, however counts are SECTOR specific
    MPARAM(_iedThresholdXL)                         = 90; // +20
    MPARAM(_iedThresholdL)                          = 70; // +25
    MPARAM(_iedThresholdM)                          = 45; // +30
    MPARAM(_iedThresholdS)                          = 15;
};

if (hasInterface) then {
};

true;
