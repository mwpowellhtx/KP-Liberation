/*
    KPLIB_fnc_core_settings

    File: fn_core_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-11
    Last Update: 2021-05-21 11:59:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA Settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    KPLIB_param_core_minPlayerStrength = 0.25;
    KPLIB_param_core_maxPlayerStrength = 0.75;
};

/*
    ----- BI REVIVE SETTINGS -----
    Ref: https://community.bistudio.com/wiki/Arma_3_Revive
 */

// KPLIB_param_reviveMode
// Enables/Disables the BI Revive System. (Automatically disabled if using ACE medical)
// Default: Enabled
[
    "KPLIB_param_reviveMode",
    "LIST",
    [localize "STR_A3_ReviveMode", localize "STR_KPLIB_SETTINGS_REVIVE_MODE_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [
        [
            0,
            1
        ],
        [
            localize "STR_A3_Disabled",
            localize "STR_A3_EnabledForAllPlayers"
        ],
        1
    ],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveDuration
// How long it takes to revive someone in seconds.
// Default: 6
[
    "KPLIB_param_reviveDuration",
    "LIST",
    [localize "STR_A3_ReviveDuration", localize "STR_KPLIB_SETTINGS_REVIVE_DURATION_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [[6, 8, 10, 12, 15, 20, 25, 30], ["6", "8", "10", "12", "15", "20", "25", "30"], 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveRequiredTrait
// Controls whether special training is required to revive someone.
// Default: 1
[
    "KPLIB_param_reviveRequiredTrait",
    "LIST",
    [localize "STR_A3_RequiredTrait", localize "STR_KPLIB_SETTINGS_REVIVE_REQTRAIT_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [
        [
            0,
            1
        ],
        [
            localize "STR_A3_None",
            localize "STR_A3_Medic"
        ],
        1
    ],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveMedicSpeedMultiplier
// Decreases the time it takes for a Medic to revive someone.
// Default: 1x
[
    "KPLIB_param_reviveMedicSpeedMultiplier",
    "LIST",
    [localize "STR_A3_RequiredTrait_MedicSpeedMultiplier", localize "STR_KPLIB_SETTINGS_REVIVE_SPEEDMULT_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [[1, 1.5, 2, 2.5, 3], ["1x", "1.5x", "2x", "2.5x", "3x"], 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveRequiredItems
// Controls whether any items are required to revive someone.
// Default: Medikit
[
    "KPLIB_param_reviveRequiredItems",
    "LIST",
    [localize "STR_A3_RequiredItems", localize "STR_KPLIB_SETTINGS_REVIVE_REQITEM_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [
        [
            0,
            1,
            2
        ],
        [
            localize "STR_A3_None",
            localize "STR_A3_Medikit",
            localize "STR_A3_FirstAidKitOrMedikit"
        ],
        1
    ],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveUnconsciousStateMode
// How deep is the simulation of damage and incapacitation.
// Default: Basic
[
    "KPLIB_param_reviveUnconsciousStateMode",
    "LIST",
    [localize "STR_A3_IncapacitationMode", localize "STR_KPLIB_SETTINGS_REVIVE_INCAPMODE_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [
        [
            0,
            1,
            2
        ],
        [
            localize "STR_A3_Basic",
            localize "STR_A3_Advanced",
            localize "STR_A3_Realistic"
        ],
        0
    ],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveBleedOutDuration
// How long it takes to bleed out in seconds when incapacitated.
// Default: 180 seconds
[
    "KPLIB_param_reviveBleedOutDuration",
    "LIST",
    [localize "STR_A3_BleedOutDuration", localize "STR_KPLIB_SETTINGS_REVIVE_BLEEDOUT_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [[10, 15, 20, 30, 45, 60, 90, 180], ["10", "15", "20", "30", "45", "60", "90", "180"], 7],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_reviveForceRespawnDuration
// How long it takes players in seconds to force their respawn.
// Default: 10 seconds
[
    "KPLIB_param_reviveForceRespawnDuration",
    "LIST",
    [localize "STR_A3_ForceRespawnDuration", localize "STR_KPLIB_SETTINGS_REVIVE_RESPAWN_TT"],
    localize "STR_KPLIB_SETTINGS_REVIVE",
    [[3, 4, 5, 6, 7, 8, 9, 10], ["3", "4", "5", "6", "7", "8", "9", "10"], 7],
    1,
    {}
] call CBA_Settings_fnc_init;

// TODO: TBD: arrange proper CBA settings...
KPLIB_param_core_updatePlayerProximityPeriod = 1;

true;
