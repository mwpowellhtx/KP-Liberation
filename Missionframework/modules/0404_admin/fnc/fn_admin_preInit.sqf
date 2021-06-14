/*
    KPLIB_fnc_admin_preInit

    File: fn_admin_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-18
    Last Update: 2021-06-14 16:47:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["[fn_admin_preInit] Initializing...", "PRE] [ADMIN", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    ["[fn_admin_preInit] Initialized", "PRE] [ADMIN", true] call KPLIB_fnc_common_log;
};

true
