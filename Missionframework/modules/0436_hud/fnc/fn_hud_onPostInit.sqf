#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onPostInit

    File: fn_hud_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 10:49:06
    Last Update: 2021-05-27 10:49:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (hasInterface) then {
    ["[fn_hud_onPostInit] Initializing...", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    ["[fn_hud_onPostInit] Initialized", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

true;
