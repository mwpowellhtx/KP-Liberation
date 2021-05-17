/*
    KPLIB_fnc_timers_onPostInit

    File: fn_timers_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:36:37
    Last Update: 2021-02-03 15:36:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):

    Returns:
*/

if (isServer) then {
    [format ["[fn_timers_onPostInit] Initializing..."], "POST] [TIMERS", true] call KPLIB_fnc_common_log;
};

// For convenience throughout
KPLIB_timers_defaultComponentString = KPLIB_timers_default call KPLIB_fnc_timers_renderComponentString;

if (isServer) then {
    [format ["[fn_timers_onPostInit] Initialized"], "POST] [TIMERS", true] call KPLIB_fnc_common_log;
};

true;
