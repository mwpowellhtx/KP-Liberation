/*
    KPLIB_fnc_logistics_settings

    File: fn_logistics_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

[
    "KPLIB_param_logistics_debug"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_DEBUG", localize "STR_KPLIB_SETTINGS_LOGISTICS_DEBUG_TT"]
    , localize "STR_KPLIB_SETTINGS_DEBUG"
    , false // default: false
    , 0 // Because debugging may make sense either on client or server
    , {}
] call CBA_Settings_fnc_init;

true;
