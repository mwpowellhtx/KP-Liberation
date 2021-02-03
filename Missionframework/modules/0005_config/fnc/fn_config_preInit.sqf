/*
    KPLIB_fnc_config_preInit

    File: fn_config_preInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 13:29:15
    Last Update: 2021-01-28 13:29:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Config pre initialization handler.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

[] call KPLIB_fnc_config_presets;

[] call KPLIB_fnc_config_settings;

true
