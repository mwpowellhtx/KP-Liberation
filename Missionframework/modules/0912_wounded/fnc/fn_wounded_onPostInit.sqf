#include "script_component.hpp"
/*
    KPLIB_fnc_wounded_onPostInit

    File: fn_wounded_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 15:04:42
    Last Update: 2021-04-26 15:04:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
*/

if (isServer) then {
    ["[fn_wounded_onPostInit] Initializing...", "POST] [WOUNDED", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init
};

if (isServer) then {
    ["[fn_wounded_onPostInit] Initialized", "POST] [WOUNDED", true] call KPLIB_fnc_common_log;
};

true;
