/*
    KPLIB_fnc_notification_onPreInit

    File: fn_notification_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:03:30
    Last Update: 2021-04-04 13:39:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
*/

if (hasInterface) then {
    ["[fn_notification_onPreInit] Initializing...", "PRE] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    KPLIB_notification_delay = 5;
};

if (hasInterface) then {
    ["[fn_notification_onPreInit] Initialized.", "PRE] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

true;
