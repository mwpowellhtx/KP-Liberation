/*
    KPLIB_fnc_missions_onPostInit

    File: fn_missions_onPostInit.sqf
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
    ["Initializing...", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init
};

if (isServer) then {
    ["Initialized", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;
};

true;
