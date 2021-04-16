#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_onPreInit

    File: fn_enemy_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-05 15:48:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
 */

if (isServer) then {
    ["[fn_enemy_onPreInit] Initializing...", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNC(_settings);

// Server section (dedicated and player hosted)
if (isServer) then {

    // Awareness of the enemy (0-100)
    MVAR(_awareness)                                                = MPARAM(_defaultAwareness);

    // All enemy patrols
    MVAR(_patrols)                                                  = [];

    // Strength of the enemy (0-1000)
    MVAR(_strength)                                                 = MPARAM(_defaultStrength);

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_enemy_loadData;}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_enemy_saveData;}] call CBA_fnc_addEventHandler;

    // Register sector activation event handler
    [KPLIB_sector_activated, {[_this select 0] call KPLIB_fnc_enemy_sectorAct;}] call CBA_fnc_addEventHandler;

    // Register sector captured event handler
    [KPLIB_sector_captured, {[_this select 0] call KPLIB_fnc_enemy_sectorCapture;}] call CBA_fnc_addEventHandler;

    // Register sector deactivation event handler
    [KPLIB_sector_deactivated, {[_this select 0] call KPLIB_fnc_enemy_sectorDeact;}] call CBA_fnc_addEventHandler;

    // Register convoy arrival event handler
    [Q(KPLIB_transferConvoy_end), { _this call KPLIB_fnc_enemy_onTransferConvoyEnd; }] call CBA_fnc_addEventHandler;

    // TODO: TBD: for follow up later: https://github.com/mwpowellhtx/KP-Liberation/issues/78
    // TODO: TBD: for now, making a best possible effort to minimize the shake up in order to accomplish HUD overlays
    // TODO: TBD: we think these only ever need to be defined server side...

    MPRESET(_awareness)                                             = Q(awareness);
    MPRESET(_strength)                                              = Q(strength);
    MPRESET(_defend)                                                = Q(defend);
    MPRESET(_skirmish)                                              = Q(skirmish);
    MPRESET(_reinforce)                                             = Q(reinforce);
    MPRESET(_counterattack)                                         = Q(counterattack);

    // For use with getting awareness threshold
    MPRESET(_lessOrEqual)                                           = Q(le);
    MPRESET(_greaterOrEqual)                                        = Q(ge);
    MPRESET(_thresholdDelim)                                        = Q(:);

    // TODO: TBD: the approach is penciled in for now, will want to revise it later...
    MPRESET(_thresholdMap)                                          = [
            MPRESET(_awareness)
            , MPRESET(_strength)
            , MPRESET(_defend)
            , MPRESET(_skirmish)
            , MPRESET(_reinforce)
            , MPRESET(_counterattack)
            , MPRESET(_thresholdDelim)
        ] call {
        params [
            Q(_awareness)
            , Q(_strength)
            , Q(_defend)
            , Q(_skirmish)
            , Q(_reinforce)
            , Q(_counterattack)
            , Q(_delim)
        ];
        createHashMapFromArray [
            // Setup the AWARENESS based thresholds
            [[_awareness, _reinforce, _defend] joinString _delim        , MPARAM(_awarenessThresholdReinforceDefend)        ]
            , [[_awareness, _defend, _reinforce] joinString _delim      , MPARAM(_awarenessThresholdDefendReinforce)        ]
            //  ^^^^^^^^^^
            , [[_awareness, _reinforce, _skirmish] joinString _delim    , MPARAM(_awarenessThresholdReinforceSkirmish)      ]
            , [[_awareness, _counterattack, _skirmish] joinString _delim, MPARAM(_awarenessThresholdCounterattackSkirmish)  ]
            , [[_awareness, _skirmish, _reinforce] joinString _delim    , MPARAM(_awarenessThresholdSkirmishReinforce)      ]
            , [[_awareness, _skirmish, _counterattack] joinString _delim, MPARAM(_awarenessThresholdSkirmishCounterattack)  ]
            // Setup some STRENGTH based thresholds
            , [[_strength, _reinforce, _defend] joinString _delim       , MPARAM(_strengthThresholdReinforceDefend)         ]
            //  ^^^^^^^^^
            , [[_strength, _defend, _reinforce] joinString _delim       , MPARAM(_strengthThresholdDefendReinforce)         ]
            , [[_strength, _reinforce, _skirmish] joinString _delim     , MPARAM(_strengthThresholdReinforceSkirmish)       ]
            , [[_strength, _skirmish, _counterattack] joinString _delim , MPARAM(_strengthThresholdSkirmishCounterattack)   ]
        ];
    };
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_enemy_onPreInit] Initialized", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

true;
