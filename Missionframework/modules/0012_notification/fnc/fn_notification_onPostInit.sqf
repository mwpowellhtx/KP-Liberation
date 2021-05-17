/*
    KPLIB_fnc_notification_onPostInit

    File: fn_notification_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:06:41
    Last Update: 2021-04-04 13:40:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):

    Returns:
*/

if (hasInterface) then {
    ["[fn_notification_onPostInit] Initializing...", "POST] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    ["[fn_notification_onPostInit] Initialized.", "POST] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

true;
