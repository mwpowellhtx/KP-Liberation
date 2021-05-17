/*
    KPLIB_fnc_logisticsSM_onPendingLoading

    File: fn_logisticsSM_onPendingLoading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 17:38:06
    Last Update: 2021-03-07 21:34:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onPendingLoading_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

// TODO: TBD: probably do not need to bundle any bits from the namespace here...
([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_convoy"
];

_convoy = +_convoy;

[
    [_status] call KPLIB_fnc_logistics_getStatusReport
    , [_namespace] call KPLIB_fnc_logistics_convoyIsFull
] params [
    "_statusReport"
    , "_full"
];

if (_debug) then {
    [format ["[fn_logisticsSM_onPendingLoading] Entering: [_full, _statusReport, _convoy]: %1"
        , str [_full, _statusReport, _convoy]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

private _timer = [KPLIB_param_logistics_transportLoadTimeSeconds] call KPLIB_fnc_timers_create;

[_namespace, [
    [KPLIB_logistics_timer, _timer]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsSM_onPendingLoading] Entering: [_timer]: %1"
        , str [_timer]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
