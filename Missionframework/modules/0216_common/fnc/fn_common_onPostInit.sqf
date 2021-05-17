/*
    KPLIB_fnc_common_onPostInit

    File: fn_common_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-04
    Last Update: 2021-03-20 15:29:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Color
        https://www.w3schools.com/colors/colors_picker.asp
*/

if (isServer) then {
    ["[fn_common_onPostInit] Initializing...", "POST] [COMMON", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    ["KPLIB_unit_created", KPLIB_fnc_common_onUnitCreated] call CBA_fnc_addEventHandler;
    ["KPLIB_group_created", KPLIB_fnc_common_onGroupCreated] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_common_onPostInit] Initialized", "POST] [COMMON", true] call KPLIB_fnc_common_log;
};

true;
