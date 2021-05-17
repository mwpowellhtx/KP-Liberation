/*
    KPLIB_fnc_config_onPreInit

    File: fn_config_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 13:29:15
    Last Update: 2021-05-17 12:16:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

[] call KPLIB_fnc_config_presets;

[] call KPLIB_fnc_config_settings;

true;
