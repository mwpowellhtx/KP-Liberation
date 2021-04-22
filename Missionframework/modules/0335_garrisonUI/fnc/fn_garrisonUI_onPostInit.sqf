#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_garrisonUI_onPostInit

    File: fn_garrisonUI_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:11:38
    Last Update: 2021-04-16 14:11:40
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
    ["[fn_garrisonUI_onPostInit] Initializing...", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

[] call MFUNCUI(_setupPermissions);

[] call MFUNCUI(_setupPlayerActions);

if (isServer) then {
    // Server section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_garrisonUI_onPostInit] Initialized", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

true;
