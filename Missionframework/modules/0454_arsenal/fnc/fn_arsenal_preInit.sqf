/*
    KPLIB_fnc_arsenal_preInit

    File: fn_arsenal_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-11-14
    Last Update: 2021-05-20 10:29:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_arsenal_preInit] Initializing...", "PRE] [ARSENAL", true] call KPLIB_fnc_common_log;
};

// Process CBA settings
[] call KPLIB_fnc_arsenal_settings;

/*
    ----- Module Globals -----
 */

// Array of all whitelisted arsenal items
KPLIB_preset_arsenal_whitelist = [];

 // Array of all blacklisted arsenal items
KPLIB_preset_arsenal_blacklist = [];

if (hasInterface) then {

    // Set BACKPACK and verify GEAR on DISPLAY OPENED+CLOSED
    ["ace_arsenal_displayOpened", { player setVariable ["KPLIB_backpack", backpack player]; }] call CBA_fnc_addEventHandler;
    ["ace_arsenal_displayClosed", { [] call KPLIB_fnc_arsenal_checkGear; }] call CBA_fnc_addEventHandler;

    // Setup PLAYER ACTIONS and verify GEAR on REDEPLOY
    ["KPLIB_player_redeploy", {
        _this call KPLIB_fnc_arsenal_setupPlayerActions;
        [] call KPLIB_fnc_arsenal_checkGear;
    }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_arsenal_preInit] Initialized", "PRE] [ARSENAL", true] call KPLIB_fnc_common_log;
};

true;
