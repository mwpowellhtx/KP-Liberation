/*
    KPLIB_fnc_logisticsCO_settings

    File: fn_logisticsCO_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-15 18:40:41
    Last Update: 2021-03-15 18:40:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

// TODO: TBD: refactor as proper pre-init, minimum... even CBA settings...
// It is an imprecise estimate, so we model it best we can
KPLIB_param_logistics_reroute_enRouteCoefficient    = 0.5;
KPLIB_param_logistics_reroute_loadingCoefficient    = 0.25;
KPLIB_param_logistics_reroute_unloadingCoefficient  = 0.75;

// // TODO: TBD: starting with hard-coded settings, eventually landing in proper CBA settings...
// [
//     "KPLIB_param_logistics_reroute_enRouteCoefficient"
//     , "SLIDER"
//     , [localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_EN_ROUTE_COEF", localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_EN_ROUTE_COEF_TT"]
//     , localize "STR_KPLIB_SETTINGS_LOGISTICS"
//     , [0, 1, 0.5, 2] // range: [0, 1], default: 0.5, 2 places
//     , 2 // server side only
//     , {}
// ] call CBA_Settings_fnc_init;

// [
//     "KPLIB_param_logistics_reroute_loadingCoefficient"
//     , "SLIDER"
//     , [localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_LOADING_COEF", localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_LOADING_COEF_TT"]
//     , localize "STR_KPLIB_SETTINGS_LOGISTICS"
//     , [0, 1, 0.25, 2] // range: [0, 1], default: 0.5, 2 places
//     , 2 // server side only
//     , {}
// ] call CBA_Settings_fnc_init;

// [
//     "KPLIB_param_logistics_reroute_unloadingCoefficient"
//     , "SLIDER"
//     , [localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_UNLOADING_COEF", localize "STR_KPLIB_SETTINGS_LOGISTICSCO_REROUTE_UNLOADING_COEF_TT"]
//     , localize "STR_KPLIB_SETTINGS_LOGISTICS"
//     , [0, 1, 0.75, 2] // range: [0, 1], default: 0.5, 2 places
//     , 2 // server side only
//     , {}
// ] call CBA_Settings_fnc_init;

true;
