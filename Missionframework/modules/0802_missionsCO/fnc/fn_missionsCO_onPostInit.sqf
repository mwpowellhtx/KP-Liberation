#include "script_component.hpp"
/*
    KPLIB_fnc_missionsCO_onPostInit

    File: fn_missionsCO_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2021-03-19 17:42:23
    Last Update: 2021-03-19 17:42:26
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
    ["Initializing...", "POST] [MISSIONSCO", true] call KPLIB_fnc_common_log;
};



if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Setup of actions available to players
    [MVAR(_request), MFUNC(_onRequest)] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["Initialized", "POST] [MISSIONSCO", true] call KPLIB_fnc_common_log;
};

true
