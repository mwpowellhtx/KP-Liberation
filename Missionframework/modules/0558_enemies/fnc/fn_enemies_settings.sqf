#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_settings

    File: fn_enemies_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-05-05 10:44:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the module settings.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

/*
    ----- ENEMY COMMANDER SETTINGS -----
 */

[
    QMPARAM(_maxStrength)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_STRENGTH_MAX", localize "STR_KPLIB_SETTINGS_ENEMY_STRENGTH_MAX_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [250, 5000, 1000, 0] // range: [250, 5000], default: 1000
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_defaultStrength)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_STRENGTH_DEFAULT", localize "STR_KPLIB_SETTINGS_ENEMY_STRENGTH_DEFAULT_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [250, 5000, 0, 0] // range: [250, 5000], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_maxAwareness)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_AWARENESS_MAX", localize "STR_KPLIB_SETTINGS_ENEMY_AWARENESS_MAX_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [0, 500, 100, 0] // range: [0, 500], default: 100
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_defaultAwareness)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_AWARENESS_DEFAULT", localize "STR_KPLIB_SETTINGS_ENEMY_AWARENESS_DEFAULT_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [0, 500, 0, 0] // range: [0, 500], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_cityCaptureReward)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CAPTURE_REWARD_CITY", localize "STR_KPLIB_SETTINGS_ENEMY_CAPTURE_REWARD_CITY_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [3, 11, 7, 0] // range: [3, 11], default: 7
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_metropolisCaptureCoef)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CAPTURE_COEFFICIENT_METROPOLIS", localize "STR_KPLIB_SETTINGS_ENEMY_CAPTURE_COEFFICIENT_METROPOLIS_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [1, 5, 1.5, 3] // range: [1, 5], default: 1.5
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_maxCivRep)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_MAX", localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_MAX_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [250, 2500, 1000, 0] // range: [250, 2500], default: 1000
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_defaultCivRep)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_DEFAULT", localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_DEFAULT_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [-2500, 2500, 0, 0] // range: [-2500, 2500], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_civKilledPenalty)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CIV_KILLED_PENALTY", localize "STR_KPLIB_SETTINGS_ENEMY_CIV_KILLED_PENALTY_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [0, 13, 7, 0] // range: [0, 13], default: 7
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_civRepBaseThreshold)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_BASE_THRESHOLD", localize "STR_KPLIB_SETTINGS_ENEMY_CIV_REP_BASE_THRESHOLD_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [3, 33, 25, 0] // range: [3, 32], default: 25
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_buildingDamageMaxPenalty)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_BUILDING_DAMAGE_MAX_PENALTY", localize "STR_KPLIB_SETTINGS_ENEMY_BUILDING_DAMAGE_MAX_PENALTY_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , [0, 7, 4, 0] // range: [0, 7], default: 4
    , 1
    , {}
] call CBA_fnc_addSetting;

// TODO: TBD: we will arrange for the setting, but it is unused today...
[
    QMPARAM(_assessPartialBuildingDamage)
    , Q(CHECKBOX)
    , [localize "STR_KPLIB_SETTINGS_ENEMY_ASSESS_PARTIAL_BUILDING_DAMAGE", localize "STR_KPLIB_SETTINGS_ENEMY_ASSESS_PARTIAL_BUILDING_DAMAGE_TT"]
    , localize "STR_KPLIB_SETTINGS_ENEMY"
    , false // default
    , 1
    , {}
] call CBA_fnc_addSetting;

if (isServer) then {

    MPARAM(_addAwareness_debug)                                     = false;
    MPARAM(_addStrength_debug)                                      = false;
    MPARAM(_addCivRep_debug)                                        = false;
    MPARAM(_getStrengthRatio_debug)                                 = false;
    MPARAM(_getCivRepBounded_debug)                                 = false;
    MPARAM(_getCivRepRatio_debug)                                   = false;
    MPARAM(_getCivRepHostilityRatio_debug)                          = false;
    MPARAM(_onRegisterBuildings_debug)                              = false;
    MPARAM(_onSectorCaptured_debug)                                 = false;
    MPARAM(_onBuildingsDestroyed_debug)                             = false;
    MPARAM(_allowBuildingDestruction_debug)                         = false;
    MPARAM(_getSectorCaptureReward_debug)                           = false;

    // TODO: TBD: could wire this up in terms of settings
    MPARAM(_strengthDeltaPeriod)                                    = 1800;

    // TODO: TBD: not sure yet what will happen with 'chance' ...
    MPARAM(_strengthLightVehicleChance)                             =   50;
    MPARAM(_strengthHeavyVehicleChance)                             =   25;

    // // TODO: TBD: refactoring to SECTORS module...
    // MPARAM(_patrolDuration)                                         =   30;

    // TODO: TBD: ditto strength, re: params, etc
    // TODO: TBD: under no circumstaces should we tune these unless we know what we are doing...
    // TODO: TBD: not least of which the commander logic FSM is **UGLY** to say the least
    // TODO: TBD: in fact the FSM could really be revised and simplified if possible...
    MPARAM(_awarenessThresholdReinforceDefend)                      =   20;
    MPARAM(_awarenessThresholdDefendReinforce)                      =   35;
    MPARAM(_awarenessThresholdReinforceSkirmish)                    =   50;
    MPARAM(_awarenessThresholdCounterattackSkirmish)                =   65;
    MPARAM(_awarenessThresholdSkirmishReinforce)                    =   40;
    MPARAM(_awarenessThresholdSkirmishCounterattack)                =   75;

    MPARAM(_strengthThresholdReinforceDefend)                       =  200;
    MPARAM(_strengthThresholdDefendReinforce)                       =  350;
    MPARAM(_strengthThresholdReinforceSkirmish)                     =  500;
    MPARAM(_strengthThresholdSkirmishCounterattack)                 =  750;

    MPARAM(_updateDispositionPeriod)                                =   30;
};

// TODO: TBD: will pick up this effort later... objective: reposition debug flags to central "debug" settings area
private _enemy = [
    [
        QMPARAM(_debug)
        , {
            [
                _this
                , Q(CHECKBOX)
                , [localize "STR_KPLIB_SETTINGS_DEBUG_ENEMY", localize "STR_KPLIB_SETTINGS_DEBUG_ENEMY_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , true // default
                , 1
                , {}
            ];
        }
    ]
];

{
    [_x, _forEachIndex] call KPLIB_fnc_config_onRegisterSettings;
} forEach [_enemy];

true;
