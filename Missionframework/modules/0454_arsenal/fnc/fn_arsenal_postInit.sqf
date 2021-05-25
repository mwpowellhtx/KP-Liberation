/*
    KPLIB_fnc_arsenal_postInit

    File: fn_arsenal_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-11-12
    Last Update: 2021-05-25 12:41:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_addScriptedEventHandler
        https://community.bistudio.com/wiki/Arma_3:_Scripted_Event_Handlers
 */

if (isServer) then {
    ["[fn_arsenal_postInit] Initializing...", "POST] [ARSENAL", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {

    // Add event handler for gear check
    [missionNamespace, "arsenalOpened", { player setVariable ["KPLIB_backpack", backpack player]; }] call BIS_fnc_addScriptedEventHandler;

    [missionNamespace, "arsenalClosed", { [] call KPLIB_fnc_arsenal_checkGear; }] call BIS_fnc_addScriptedEventHandler;
};

if (isServer) then {
    ["[fn_arsenal_postInit] Initialized", "POST] [ARSENAL", true] call KPLIB_fnc_common_log;
};

true;
