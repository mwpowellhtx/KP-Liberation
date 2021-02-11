/*
    KPLIB_fnc_production_settings

    File: fn_production_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:02:17
    Last Update: 2021-02-04 22:58:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA Settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

/*
    ----- PRODUCTION SETTINGS -----
*/

[
    "KPLIB_param_production_leadTime"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_LEADTIME", localize "STR_KPLIB_SETTINGS_PROD_LEADTIME_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [30, 1000000, 1800, 0] // default: 30m, range: [30s, 1w+], 1w = 604,800s
    , 2 // Because these are some delicate server only settings
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_defaultCost"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_DEFAULTCOST", localize "STR_KPLIB_SETTINGS_PROD_DEFAULTCOST_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [0, 1000, 100, 0] // default: 100, range: [0, 1000]
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_targetCost"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_TARGETCOST", localize "STR_KPLIB_SETTINGS_PROD_TARGETCOST_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [0, 500, 50, 0] // default: 50, range: [0, 500]
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_creditFob"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_PROD_CREDITFOB", localize "STR_KPLIB_SETTINGS_PROD_CREDITFOB_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , false // default: false
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_yield"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_YIELD", localize "STR_KPLIB_SETTINGS_PROD_YIELD_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [100, 300, 100, 0] // default: 100, range: [100, 300]
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_maxQueueDepth"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_MAXQUEUEDEPTH", localize "STR_KPLIB_SETTINGS_PROD_MAXQUEUEDEPTH_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [1, 8, 4, 0] // default: 4, range: [1, 7]
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_production_debug"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_PROD_DEBUG", localize "STR_KPLIB_SETTINGS_PROD_DEBUG_TT"]
    , localize "STR_KPLIB_SETTINGS_DEBUG"
    , false // default: false
    , 0 // Because debugging may make sense either on client or server
    , {}
] call CBA_Settings_fnc_init;

true
