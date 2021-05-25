/*
    KPLIB_fnc_config_settings

    File: fn_config_settings.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-28 15:24:28
    Last Update: 2021-05-23 11:59:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the CBA settings.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// TODO: TBD: settings are "init" ...
// TODO: TBD: these probably need to be broken out as well we think...

private _noop = {};

private _debug = +[
    [
        // Enables/Disables extended Liberation debug output for the server log [default: true]
        "KPLIB_param_debug"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_DEBUG_ALL", localize "STR_KPLIB_SETTINGS_DEBUG_ALL_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , true
                , 1
                , _noop
            ];
        }
    ]
    , [
        // Enables/Disables detailed rpt logging of each saving process [default: false]
        "KPLIB_param_savedebug"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_DEBUG_SAVE", localize "STR_KPLIB_SETTINGS_DEBUG_SAVE_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , false
                , 1
                , _noop
            ];
        }
    ]
    , [
        // Enables/Disables detailed rpt logging of the build process [default: false]
        "KPLIB_param_builddebug"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_DEBUG_BUILD", localize "STR_KPLIB_SETTINGS_DEBUG_BUILD_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , false
                , 1
                , _noop
            ];
        }
    ]
];

private _general = +[
    [
        // Interval of periodic saves in seconds [default: 60]
        "KPLIB_param_saveInterval"
        , {
            [
                _this
                , "SLIDER"
                , [localize "STR_KPLIB_SETTINGS_GENERAL_SAVEINT", localize "STR_KPLIB_SETTINGS_GENERAL_SAVEINT_TT"]
                , localize "STR_KPLIB_SETTINGS_GENERAL"
                , [30, 600, 60, 0]
                , 1
                , _noop
            ];
        }
    ]
    , [
        // Enables/Disables the BI stamina system; does notaffect ACE Advanced Fatigue [default: true]
        "KPLIB_param_stamina"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_GENERAL_STAMINA", localize "STR_KPLIB_SETTINGS_GENERAL_STAMINA_TT"]
                , localize "STR_KPLIB_SETTINGS_GENERAL"
                , true
                , 1
                , _noop
            ];
        }
    ]
    , [
        // Enables/Disables if spawned vehicles will have an empty cargo space [default: true]
        "KPLIB_param_clearVehicleCargo"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_GENERAL_CLEARCARGO", localize "STR_KPLIB_SETTINGS_GENERAL_CLEARCARGO_TT"]
                , localize "STR_KPLIB_SETTINGS_GENERAL"
                , true
                , 1
                , _noop
            ];
        }
    ]
    , [
        // Time Multiplier [default: 4x]
        "KPLIB_param_timeMulti"
        , {
            [
                _this
                , "SLIDER"
                , [localize "STR_KPLIB_SETTINGS_GENERAL_TIMEMULTI", localize "STR_KPLIB_SETTINGS_GENERAL_TIMEMULTI_TT"]
                , localize "STR_KPLIB_SETTINGS_GENERAL"
                , [1, 24, 4, 0]
                , 1
                , {[] call KPLIB_fnc_init_timeMultiApply;}
            ];
        }
    ]
];

private _playerPresets = [4, "STR_KPLIB_SETTINGS_PRESET_ARMY_", 2] call KPLIB_fnc_config_getPresetSettingValue;
private _enemyPresets = [4, "STR_KPLIB_SETTINGS_PRESET_ARMY_"] call KPLIB_fnc_config_getPresetSettingValue;
private _resistancePresets = [2, "STR_KPLIB_SETTINGS_PRESET_RESIS_"] call KPLIB_fnc_config_getPresetSettingValue;
private _civilianPresets = [2, "STR_KPLIB_SETTINGS_PRESET_CIV_"] call KPLIB_fnc_config_getPresetSettingValue;

private _presets = +[
    [
        // Selection for the units, vehicles, etc. for the player side [default: Custom West Army]
        "KPLIB_param_presetF"
        , {
            [
                _this
                , "LIST"
                , [localize "STR_KPLIB_SETTINGS_PRESET_PLAYER", localize "STR_KPLIB_SETTINGS_PRESET_PLAYER_TT"]
                , localize "STR_KPLIB_SETTINGS_PRESET"
                , _playerPresets
                , 1
                , _noop
                , true
            ];
        }
    ]
    , [
        // Selection for the units, vehicles, etc. for the enemy side [default: Custom East Army]
        "KPLIB_param_presetE"
        , {
            [
                _this
                , "LIST"
                , [localize "STR_KPLIB_SETTINGS_PRESET_ENEMY", localize "STR_KPLIB_SETTINGS_PRESET_ENEMY_TT"]
                , localize "STR_KPLIB_SETTINGS_PRESET"
                , _enemyPresets
                , 1
                , _noop
                , true
            ];
        }
    ]
    , [
        // Selection for the units, vehicles, etc. for the resistance side [default: Custom Preset]
        "KPLIB_param_presetR"
        , {
            [
                _this
                , "LIST"
                , [localize "STR_KPLIB_SETTINGS_PRESET_RESIS", localize "STR_KPLIB_SETTINGS_PRESET_RESIS_TT"]
                , localize "STR_KPLIB_SETTINGS_PRESET"
                , _resistancePresets
                , 1
                , _noop
                , true
            ];
        }
    ]
    , [
        // Selection for the units, vehicles, etc. for the civilian side [default: Custom Preset]
        "KPLIB_param_presetC"
        , {
            [
                _this
                , "LIST"
                , [localize "STR_KPLIB_SETTINGS_PRESET_CIV", localize "STR_KPLIB_SETTINGS_PRESET_CIV_TT"]
                , localize "STR_KPLIB_SETTINGS_PRESET"
                , _civilianPresets
                , 1
                , _noop
                , true
            ];
        }
    ]
];

// TODO: TBD: Follow up, see: https://github.com/mwpowellhtx/KP-Liberation/issues/10
{
    [_x, _forEachIndex] call KPLIB_fnc_config_onRegisterSettings;
} forEach [_debug, _general, _presets];

true
