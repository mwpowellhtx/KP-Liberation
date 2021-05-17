/*
    KPLIB_fnc_logistics_settings

    File: fn_logistics_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-28 22:40:12
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

[
    "KPLIB_param_logistics_transportBaseCost"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_BASE_COST", localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_BASE_COST_TT"]
    , localize "STR_KPLIB_SETTINGS_LOGISTICS"
    , [0, 500, 100, 0] // range: [0, 500], default: 100, no dec
    , 2 // server side only
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_logistics_transportRecycleValue"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_RECYCLE_VALUE", localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_RECYCLE_VALUE_TT"]
    , localize "STR_KPLIB_SETTINGS_LOGISTICS"
    , [0, 100, 50, 0] // range: [0, 100], default: 50, no dec
    , 2 // server side only
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_logistics_transportSpeedKph"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_SPEED_KPH", localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_SPEED_KPH_TT"]
    , localize "STR_KPLIB_SETTINGS_LOGISTICS"
    // Using 1.6093440006147 factor for MPH, i.e. (kph * _to_mph)
    , [25, 350, 45, 0] // range: [25, 350], default: 45, no dec
    , 2 // server side only
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_logistics_transportLoadTimeSeconds"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_LOAD_TIME", localize "STR_KPLIB_SETTINGS_LOGISTICS_TRANSPORT_LOAD_TIME_TT"]
    , localize "STR_KPLIB_SETTINGS_LOGISTICS"
    , [0, 300, 60, 0] // range: [0, 300], default: 60, no dec
    , 2 // server side only
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_logistics_routesCanBeBlocked"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICS_ROUTES_CAN_BE_BLOCKED", localize "STR_KPLIB_SETTINGS_LOGISTICS_ROUTES_CAN_BE_BLOCKED_TT"]
    , localize "STR_KPLIB_SETTINGS_LOGISTICS"
    , true // default: true
    , 2 // server side only
    , {}
] call CBA_Settings_fnc_init;

true;
