#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onPreInit

    File: fn_hud_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 10:48:23
    Last Update: 2021-05-27 15:07:46
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
    ["[fn_hud_onPreInit] Initializing...", "PRE] [HUD", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    // Client side section
    [] call MFUNC(_presets);
    [] call MFUNC(_settings);
};

if (hasInterface) then {
    // Client side section
};

if (hasInterface) then {
    ["[fn_hud_onPreInit] Initialized", "PRE] [HUD", true] call KPLIB_fnc_common_log;
};

true;
