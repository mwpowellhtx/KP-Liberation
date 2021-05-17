#include "script_component.hpp"
/*
    KPLIB_fnc_soldiers_onPostInit

    File: fn_soldiers_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:39:09
    Last Update: 2021-05-17 15:05:37
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
    ["[fn_soldiers_onPostInit] Initializing...", "POST] [SOLDIERS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_soldiers_onPostInit] Initialized", "POST] [SOLDIERS", true] call KPLIB_fnc_common_log;
};

true;
