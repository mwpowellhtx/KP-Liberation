/*
    KPLIB_fnc_logger_postInit

    File: fn_logger_postInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:06:41
    Last Update: 2021-02-05 11:06:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):

    Returns:
*/

if (hasInterface) then {
    ["[fn_notification_preInit] Initializing...", "POST] [NOTIFICATION", true] call KPLIB_fnc_common_log;

    ["[fn_notification_preInit] Initialized.", "POST] [NOTIFICATION", true] call KPLIB_fnc_common_log;
};

true
