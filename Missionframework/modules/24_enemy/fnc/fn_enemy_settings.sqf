/*
    KPLIB_fnc_enemy_settings

    File: fn_enemy_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-01-29 11:41:53
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
