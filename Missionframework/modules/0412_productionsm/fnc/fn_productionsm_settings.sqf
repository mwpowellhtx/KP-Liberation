/*
    KPLIB_fnc_productionsm_settings

    File: fn_productionsm_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 12:33:28
    Last Update: 2021-02-23 12:33:31
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
    "KPLIB_param_productionsm_publisherPeriodSeconds"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_PUBLISHERPERIODSECONDS", localize "STR_KPLIB_SETTINGS_PROD_PUBLISHERPERIODSECONDS_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [3, 30, 3, 0] // default: 3s, range: [3s, 30s]
    , 2
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_productionsm_productionEnabled"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_PROD_PRODUCERENABLED", localize "STR_KPLIB_SETTINGS_PROD_PRODUCERENABLED_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , true // default: true
    , 2 // Because these are some delicate server only settings
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_productionsm_preemptLeadTime"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_PROD_PREEMPT_LEADTIME", localize "STR_KPLIB_SETTINGS_PROD_PREEMPT_LEADTIME_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , false // default: false
    , 2 // Because these are some delicate server only settings
    , {}
] call CBA_Settings_fnc_init;

[
    "KPLIB_param_productionsm_preemptiveLeadTimeDuration"
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_PROD_PREEMPTIVE_LEADTIME_DURATION", localize "STR_KPLIB_SETTINGS_PROD_PREEMPTIVE_LEADTIME_DURATION_TT"]
    , localize "STR_KPLIB_SETTINGS_PROD"
    , [5, 30, 10, 0] // default: 10s, range: [5s, 30s]
    , 2
    , {}
] call CBA_Settings_fnc_init;

true;
