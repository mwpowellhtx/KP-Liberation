/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoadDummyData

    File: fn_logisticsMgr_lnbTelemetry_onLoadDummyData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-28 11:34:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The TELEMETRY LISTNBOX 'onLoad' event handler for dummy data use only.

    Parameters:
        _lnbTelemetry - the logistics telemetry LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbTelemetry", _lnbTelemetry];

[_lnbTelemetry] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onClear;

private _testStatus = [
    KPLIB_logistics_status_standby
    , KPLIB_logistics_status_loading
    , KPLIB_logistics_status_enRoute
    , KPLIB_logistics_status_aborting
    , KPLIB_logistics_status_unloading
    , KPLIB_logistics_status_noResource
    , KPLIB_logistics_status_routeBlocked
    , KPLIB_logistics_status_noSpace
    , KPLIB_logistics_status_ambushed
    , KPLIB_logistics_status_abandoned
    , KPLIB_logistics_status_loadingNoResource
    , KPLIB_logistics_status_unloadingNoSpace
    , KPLIB_logistics_status_enRouteAmbushed
    , KPLIB_logistics_status_enRouteBlocked
    , KPLIB_logistics_status_enRouteAbandoned
    , KPLIB_logistics_status_abortingAmbushed
    , KPLIB_logistics_status_abortingBlocked
    , KPLIB_logistics_status_abortingAbandoned
    , KPLIB_logistics_status_enRouteAbortingAbandoned
];

private _reports = [
    selectRandom _testStatus    // _status
    , +KPLIB_timers_default     // _timer
    , random [40, 100, 150]     // _transportSpeedKph
];

// Gets the TELEMETRY REPORT HASHMAP with some infused dummy data...
private _report = [false, _reports] call KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport;

// And refresh the TELEMETRY LISTNBOX ...
[] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onRefresh;

true;
