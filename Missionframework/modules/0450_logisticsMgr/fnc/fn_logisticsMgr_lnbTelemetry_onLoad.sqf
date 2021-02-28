/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoad

    File: fn_logisticsMgr_lnbTelemetry_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbTelemetry - the logistics telemetry LISTNBOX control [CONTROL, default: controlNull]
        _config - the config

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
    , "_config"
];

lnbClear _lnbTelemetry;

private _testStatus = [
    KPLIB_logistics_status_standby
    , KPLIB_logistics_status_loading
    , KPLIB_logistics_status_enRoute
    , KPLIB_logistics_status_aborting
    , KPLIB_logistics_status_unloading
    , KPLIB_logistics_status_noResources
    , KPLIB_logistics_status_routeBlocked
    , KPLIB_logistics_status_noSpace
    , KPLIB_logistics_status_ambushed
    , KPLIB_logistics_status_abandoned
    , KPLIB_logistics_status_loadingNoResoures
    , KPLIB_logistics_status_unloadingNoSpace
    , KPLIB_logistics_status_enRouteAmbushed
    , KPLIB_logistics_status_enRouteBlocked
    , KPLIB_logistics_status_enRouteAbandoned
    , KPLIB_logistics_status_abortingAmbushed
    , KPLIB_logistics_status_abortingBlocked
    , KPLIB_logistics_status_abortingAbandoned
    , KPLIB_logistics_status_enRouteAbortingAbandoned
];

// TODO: TBD: Of course we would not have more than one of these instances, but this is for illustration purposes...
for "_i" from 0 to 19 do {

    private _status = selectRandom _testStatus;
    private _statusReport = [_status] call KPLIB_fnc_logistics_getStatusReport;

    private _timer = +KPLIB_timers_default;
    private _renderedTimeRemaining = _timer call KPLIB_fnc_timers_renderTimeRemainingString;

    private _speedKph = random [40, 100, 150];
    private _renderedSpeed = format ["%1 kph", _speedKph toFixed 2];

    private _data = [
        [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_STATUS_REPORT", _statusReport]
        , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TIME_REMAINING", _renderedTimeRemaining]
        , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TRANSPORT_SPEED", _renderedSpeed]
    ];

    {
        private _datum = _x apply { toUpper _x; };
        _lnbTelemetry lnbAddRow _datum;
    } forEach _data;
};

true;
