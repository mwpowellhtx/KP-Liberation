#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_settings

    File: fn_enemy_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-03 15:50:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA Settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

/*
    ----- ENEMY COMMANDER SETTINGS -----
 */

if (isServer) then {

    // TODO: TBD: could wire this up in terms of settings
    MPARAM(_strengthDeltaPeriod)                                    = 1800;
    MPARAM(_maxStrength)                                            = 1000;
    MPARAM(_defaultStrength)                                        =  500;

    // // TODO: TBD: refactoring to SECTORS module...
    // MPARAM(_patrolDuration)                                         =   30;

    // TODO: TBD: ditto strength, re: params, etc
    // TODO: TBD: under no circumstaces should we tune these unless we know what we are doing...
    // TODO: TBD: not least of which the commander logic FSM is **UGLY** to say the least
    // TODO: TBD: in fact the FSM could really be revised and simplified if possible...
    MPARAM(_maxAwareness)                                           =  100;
    MPARAM(_defaultAwareness)                                       =    0;
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
        // Enables/Disables debug mode for this module [default: true]
        "KPLIB_param_enemyDebug"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_DEBUG_ENEMY", localize "STR_KPLIB_SETTINGS_DEBUG_ENEMY_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , true
                , 1
                , {}
            ];
        }
    ]
];

{
    [_x, _forEachIndex] call KPLIB_fnc_config_onRegisterSettings;
} forEach [_enemy];

true
