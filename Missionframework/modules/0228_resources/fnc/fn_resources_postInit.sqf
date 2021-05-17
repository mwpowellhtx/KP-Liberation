#include "script_component.hpp"
/*
    KPLIB_fnc_resources_postInit

    File: fn_resources_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-04-21 10:42:07
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
    ["Module initializing...", "POST] [RESOURCES", true] call KPLIB_fnc_common_log;
};

// Server section (dedicated and player hosted)
if (isServer) then {
    [] call KPLIB_fnc_resources_createRefreshFactoryStorageValues;
    [] call KPLIB_fnc_resources_createRefreshFobStorageValues;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["Module initialized", "POST] [RESOURCES", true] call KPLIB_fnc_common_log;
};

true;
