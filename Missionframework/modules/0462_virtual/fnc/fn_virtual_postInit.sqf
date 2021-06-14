/*
    KPLIB_fnc_virtual_postInit

    File: fn_virtual_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-18
    Last Update: 2021-06-14 17:07:06
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
    ["[fn_virtual_postInit] Initializing...", "POST] [VIRTUAL", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {

    // Add zeus to commander
    if (vehicleVarName player isEqualTo "KPLIB_eden_commander") then {
        "KPLIB_param_commanderZeusMode" call KPLIB_fnc_virtual_initCuratorOnPlayer;
    };

    // Add zeus to sub-commander
    if (vehicleVarName player isEqualTo "KPLIB_eden_subCommander") then {
        "KPLIB_param_subCommanderZeusMode" call KPLIB_fnc_virtual_initCuratorOnPlayer;
    };

    [] call KPLIB_fnc_virtual_setupPlayerActions;
};

if (isServer) then {
    ["[fn_virtual_postInit] Initialized", "POST] [VIRTUAL", true] call KPLIB_fnc_common_log;
};

true
