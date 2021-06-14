#include "script_component.hpp"
/*
    KPLIB_fnc_hud_settings

    File: fn_hud_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 10:50:10
    Last Update: 2021-06-14 17:01:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module CBA settings.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (hasInterface) then {
    ["[fn_hud_settings] Entering...", "HUD", true] call KPLIB_fnc_common_log;
};

MPARAM(_defaultPeriod)                                  = 3;

MPARAM(_subscribe_debug)                                = true;
MPARAM(_getReport_debug)                                = false;

if (hasInterface) then {
    ["[fn_hud_settings] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
