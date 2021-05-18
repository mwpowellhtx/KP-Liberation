/*
    KPLIB_fnc_init_settings

    File: fn_init_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-09
    Last Update: 2021-05-17 20:19:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

/*
    ----- GENERAL SETTINGS -----
 */

// TODO: TBD: also did some refactoring to establish usage of the config helper functions...
// TODO: TBD: key is refactoring the individual 'CBA_Settings_fnc_init' calls in a ubiquitous array...

// KPLIB_param_saveInterval
// Interval of periodic saves in seconds.
// Default: 60
[
    "KPLIB_param_saveInterval",
    "SLIDER",
    [localize "STR_KPLIB_SETTINGS_GENERAL_SAVEINT", localize "STR_KPLIB_SETTINGS_GENERAL_SAVEINT_TT"],
    localize "STR_KPLIB_SETTINGS_GENERAL",
    [30, 600, 60, 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_stamina
// Enables/Disables the BI stamina system. (doesn't affect ACE Advanced Fatigue)
// Default: true
[
    "KPLIB_param_stamina",
    "CHECKBOX",
    [localize "STR_KPLIB_SETTINGS_GENERAL_STAMINA", localize "STR_KPLIB_SETTINGS_GENERAL_STAMINA_TT"],
    localize "STR_KPLIB_SETTINGS_GENERAL",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_clearVehicleCargo
// Enables/Disables if spawned vehicles will have an empty cargo space.
// Default: true
[
    "KPLIB_param_clearVehicleCargo",
    "CHECKBOX",
    [localize "STR_KPLIB_SETTINGS_GENERAL_CLEARCARGO", localize "STR_KPLIB_SETTINGS_GENERAL_CLEARCARGO_TT"],
    localize "STR_KPLIB_SETTINGS_GENERAL",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_opsRange
// Operational buffer zone around the Operations base
// Default: 500 meters
[
    "KPLIB_param_opsRange"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_GENERAL_OPSRANGE", localize "STR_KPLIB_SETTINGS_GENERAL_OPSRANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_GENERAL"
    , [100, 1000, 500, 0]
    , 1
    , {}
] call CBA_Settings_fnc_init;

// KPLIB_param_assetMoveRange
// Maximum range at which it is possible to deploy helicopters to the designated startbase heli flight deck.
// See '_flightDeckProxy' variable on startbase proxy for purposes of aligning assets.
// Default: 20 meters
[
    "KPLIB_param_assetMoveRange"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_GENERAL_ASSETMOVERANGE", localize "STR_KPLIB_SETTINGS_GENERAL_ASSETMOVERANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_GENERAL"
    , [10, 100, 20, 0]
    , 1
    , {}
] call CBA_Settings_fnc_init;

// KPLIB_param_timeMulti
// Time Multiplier.
// Default: 4x
[
    "KPLIB_param_timeMulti",
    "SLIDER",
    [localize "STR_KPLIB_SETTINGS_GENERAL_TIMEMULTI", localize "STR_KPLIB_SETTINGS_GENERAL_TIMEMULTI_TT"],
    localize "STR_KPLIB_SETTINGS_GENERAL",
    [1, 24, 4, 0],
    1,
    {[] call KPLIB_fnc_init_timeMultiApply;}
] call CBA_Settings_fnc_init;


/*
    ----- PRESET SETTINGS -----
*/

//// TODO: TBD: we did some work to abstract and simplify the side settings...
//// TODO: TBD: somehow that got lost in an inadvertent deletion or something...
//// TODO: TBD: pick that up again in a future issue and reconsider that...
// KPLIB_param_presetF
// Selection for the units, vehicles, etc. for the player side.
// Default: Custom West Army
[
    "KPLIB_param_presetF",
    "LIST",
    [localize "STR_KPLIB_SETTINGS_PRESET_PLAYER", localize "STR_KPLIB_SETTINGS_PRESET_PLAYER_TT"],
    localize "STR_KPLIB_SETTINGS_PRESET",
    [
        [
            0,
            1,
            2,
            3
        ],
        [
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_0",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_1",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_2",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_3"
        ],
        2
    ],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

// KPLIB_param_presetE
// Selection for the units, vehicles, etc. for the enemy side.
// Default: Custom East Army
[
    "KPLIB_param_presetE",
    "LIST",
    [localize "STR_KPLIB_SETTINGS_PRESET_ENEMY", localize "STR_KPLIB_SETTINGS_PRESET_ENEMY_TT"],
    localize "STR_KPLIB_SETTINGS_PRESET",
    [
        [
            0,
            1,
            2,
            3
        ],
        [
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_0",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_1",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_2",
            localize "STR_KPLIB_SETTINGS_PRESET_ARMY_3"
        ],
        0
    ],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

// KPLIB_param_presetR
// Selection for the units, vehicles, etc. for the resistance side.
// Default: Custom Preset
[
    "KPLIB_param_presetR",
    "LIST",
    [localize "STR_KPLIB_SETTINGS_PRESET_RESIS", localize "STR_KPLIB_SETTINGS_PRESET_RESIS_TT"],
    localize "STR_KPLIB_SETTINGS_PRESET",
    [
        [
            0,
            1
        ],
        [
            localize "STR_KPLIB_SETTINGS_PRESET_RESIS_0",
            localize "STR_KPLIB_SETTINGS_PRESET_RESIS_1"
        ],
        0
    ],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

// KPLIB_param_presetC
// Selection for the units, vehicles, etc. for the civilian side.
// Default: Custom Preset
[
    "KPLIB_param_presetC",
    "LIST",
    [localize "STR_KPLIB_SETTINGS_PRESET_CIV", localize "STR_KPLIB_SETTINGS_PRESET_CIV_TT"],
    localize "STR_KPLIB_SETTINGS_PRESET",
    [
        [
            0,
            1
        ],
        [
            localize "STR_KPLIB_SETTINGS_PRESET_CIV_0",
            localize "STR_KPLIB_SETTINGS_PRESET_CIV_1"
        ],
        0
    ],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

true
