#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_onPostInit

    File: fn_triggers_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 12:44:09
    Last Update: 2021-05-08 13:11:28
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
    ["[fn_triggers_onPostInit] Initializing...", "POST] [TRIGGERS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_triggers_onPostInit] Initialized", "POST] [TRIGGERS", true] call KPLIB_fnc_common_log;
};

true;
