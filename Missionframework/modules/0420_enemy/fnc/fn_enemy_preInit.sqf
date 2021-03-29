/*
    KPLIB_fnc_enemy_preInit

    File: fn_enemy_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-03-28 10:15:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set
        some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
 */

if (isServer) then {
    ["[fn_enemy_preInit] Initializing...", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call KPLIB_fnc_enemy_settings;

// Server section (dedicated and player hosted)
if (isServer) then {
    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_enemy_loadData;}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_enemy_saveData;}] call CBA_fnc_addEventHandler;

    // Register sector activation event handler
    ["KPLIB_sector_activated", {[_this select 0] call KPLIB_fnc_enemy_sectorAct;}] call CBA_fnc_addEventHandler;

    // Register sector captured event handler
    ["KPLIB_sector_captured", {[_this select 0] call KPLIB_fnc_enemy_sectorCapture;}] call CBA_fnc_addEventHandler;

    // Register sector deactivation event handler
    ["KPLIB_sector_deactivated", {[_this select 0] call KPLIB_fnc_enemy_sectorDeact;}] call CBA_fnc_addEventHandler;

    // Register convoy arrival event handler
    ["KPLIB_transferConvoy_end", {_this call KPLIB_fnc_enemy_handleConvoyEnd;}] call CBA_fnc_addEventHandler;

    // TODO: TBD: for follow up later: https://github.com/mwpowellhtx/KP-Liberation/issues/78
    // TODO: TBD: for now, making a best possible effort to minimize the shake up in order to accomplish HUD overlays
    // TODO: TBD: we think these only ever need to be defined server side...

    // TODO: TBD: ditto strength, re: params, etc
    // TODO: TBD: under no circumstaces should we tune these unless we know what we are doing...
    // TODO: TBD: not least of which the commander logic FSM is **UGLY** to say the least
    // TODO: TBD: in fact the FSM could really be revised and simplified if possible...
    KPLIB_param_enemy_maxAwareness                                  =  100;
    KPLIB_param_enemy_defaultAwareness                              =    0;
    KPLIB_param_enemy_awarenessThresholdReinforceDefend             =   20;
    KPLIB_param_enemy_awarenessThresholdDefendReinforce             =   35;
    KPLIB_param_enemy_awarenessThresholdReinforceSkirmish           =   50;
    KPLIB_param_enemy_awarenessThresholdCounterattackSkirmish       =   65;
    KPLIB_param_enemy_awarenessThresholdSkirmishReinforce           =   40;
    KPLIB_param_enemy_awarenessThresholdSkirmishCounterattack       =   75;

    KPLIB_param_enemy_strengthThresholdReinforceDefend              =  200;
    KPLIB_param_enemy_strengthThresholdDefendReinforce              =  350;
    KPLIB_param_enemy_strengthThresholdReinforceSkirmish            =  500;
    KPLIB_param_enemy_strengthThresholdSkirmishCounterattack        =  750;

    KPLIB_preset_enemy_awareness                                    = "awareness";
    KPLIB_preset_enemy_strength                                     = "strength";
    KPLIB_preset_enemy_defend                                       = "defend";
    KPLIB_preset_enemy_skirmish                                     = "skirmish";
    KPLIB_preset_enemy_reinforce                                    = "reinforce";
    KPLIB_preset_enemy_counterattack                                = "counterattack";

    // For use with getting awareness threshold
    KPLIB_preset_enemy_lessOrEqual                                  = "le";
    KPLIB_preset_enemy_greaterOrEqual                               = "ge";
    KPLIB_preset_enemy_thresholdDelim                               = ":";

    // TODO: TBD: the approach is penciled in for now, will want to revise it later...
    KPLIB_preset_enemy_thresholdMap                                 = [
            KPLIB_preset_enemy_awareness
            , KPLIB_preset_enemy_strength
            , KPLIB_preset_enemy_defend
            , KPLIB_preset_enemy_skirmish
            , KPLIB_preset_enemy_reinforce
            , KPLIB_preset_enemy_counterattack
            , KPLIB_preset_enemy_thresholdDelim
        ] call {
        params [
            "_awareness"
            , "_strength"
            , "_defend"
            , "_skirmish"
            , "_reinforce"
            , "_counterattack"
            , "_delim"
        ];
        createHashMapFromArray [
            // Setup the AWARENESS based thresholds
            [[_awareness, _reinforce, _defend] joinString _delim        , KPLIB_param_enemy_awarenessThresholdReinforceDefend       ]
            , [[_awareness, _defend, _reinforce] joinString _delim      , KPLIB_param_enemy_awarenessThresholdDefendReinforce       ]
            //  ^^^^^^^^^^
            , [[_awareness, _reinforce, _skirmish] joinString _delim    , KPLIB_param_enemy_awarenessThresholdReinforceSkirmish     ]
            , [[_awareness, _counterattack, _skirmish] joinString _delim, KPLIB_param_enemy_awarenessThresholdCounterattackSkirmish ]
            , [[_awareness, _skirmish, _reinforce] joinString _delim    , KPLIB_param_enemy_awarenessThresholdSkirmishReinforce     ]
            , [[_awareness, _skirmish, _counterattack] joinString _delim, KPLIB_param_enemy_awarenessThresholdSkirmishCounterattack ]
            // Setup some STRENGTH based thresholds
            , [[_strength, _reinforce, _defend] joinString _delim       , KPLIB_param_enemy_strengthThresholdReinforceDefend        ]
            //  ^^^^^^^^^
            , [[_strength, _defend, _reinforce] joinString _delim       , KPLIB_param_enemy_strengthThresholdDefendReinforce        ]
            , [[_strength, _reinforce, _skirmish] joinString _delim     , KPLIB_param_enemy_strengthThresholdReinforceSkirmish      ]
            , [[_strength, _skirmish, _counterattack] joinString _delim , KPLIB_param_enemy_strengthThresholdSkirmishCounterattack  ]
        ];
    };

    // Awareness of the enemy (0-100)
    KPLIB_enemy_awareness                                           = KPLIB_param_enemy_defaultAwareness;

    // All enemy patrols
    KPLIB_enemy_patrols                                             = [];

    // TODO: TBD: could wire this up in terms of settings
    KPLIB_param_enemy_strengthDeltaPeriod                           = 1800;
    KPLIB_param_enemy_maxStrength                                   = 1000;
    KPLIB_param_enemy_defaultStrength                               =  500;

    // Strength of the enemy (0-1000)
    KPLIB_enemy_strength                                            = KPLIB_param_enemy_defaultStrength;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_enemy_preInit] Initialized", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

true;
