#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_onPostInit

    File: fn_missionsMgr_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
 */

if (isServer) then {
    ["Initializing...", "POST] [MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Mission permission
    [
        MVAR(_permissionName)
        , {}
        , false
    ] call KPLIB_fnc_permission_addPermissionHandler;
};

if (hasInterface) then {
    // Setup of actions available to players

    [MVAR(_onMissionsPublished), MFUNC(_onMissionsPublished)] call CBA_fnc_addEventHandler;

    [] call MFUNC(_setupPlayerActions);
};

if (isServer) then {
    ["Initialized", "POST] [MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

true
