#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_garrison_onPostInit

    File: fn_garrison_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-06-14 17:12:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_garrison_onPostInit] Initializing...", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_garrison_onPostInit] Initialized", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

true;
