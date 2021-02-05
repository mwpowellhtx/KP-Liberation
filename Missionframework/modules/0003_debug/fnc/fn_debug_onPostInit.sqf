/*
    KPLIB_fnc_debug_onPostInit

    File: fn_debug_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:42:04
    Last Update: 2021-02-04 13:42:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Post initialization phase callback function.

    Parameter(s):

    Returns:
*/

["Initializing...", "POST] [DEBUG", true] call KPLIB_fnc_common_log;

["Initialized.", "POST] [DEBUG", true] call KPLIB_fnc_common_log;

true
