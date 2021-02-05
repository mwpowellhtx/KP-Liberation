/*
    KPLIB_fnc_notification_preInit

    File: fn_notification_preInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:03:30
    Last Update: 2021-02-05 11:03:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
*/

if (hasInterface) then {
    ["[fn_notification_preInit] Initializing...", "PRE] [NOTIFICATION", true] call KPLIB_fnc_common_log;

    KPLIB_notification_delay = 5;

    ["[fn_notification_preInit] Initialized.", "PRE] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

true
