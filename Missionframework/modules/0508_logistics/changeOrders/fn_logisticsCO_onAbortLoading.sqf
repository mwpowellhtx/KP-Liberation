/*
    KPLIB_fnc_logisticsCO_onAbortLoading

    File: fn_logisticsCO_onAbortLoading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 16:35:53
    Last Update: 2021-03-14 18:11:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onAbortLoading_debug}
    ]
] call KLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onAbortLoading] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// Must do a role reversal...
([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

[
    [_namespace] call KPLIB_fnc_logistics_convoyIsEmpty
] params [
    "_notEmpty"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onAbortLoading] Aborting: [_notEmpty, _endpoints apply {_x#1}]: %1"
        , str [_notEmpty, _endpoints apply {_x#1}]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

[_namespace, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_unloading, { _notEmpty; }] call KPLIB_fnc_logistics_setStatus;
[_namespace, KPLIB_logistics_status_unloading, { !_notEmpty; }] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_aborting, { _notEmpty; }] call KPLIB_fnc_logistics_setStatus;
[_namespace, KPLIB_logistics_status_aborting, { !_notEmpty; }] call KPLIB_fnc_logistics_unsetStatus;

[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
    , "_unloading"
];

private ["_timer"];

if (_standby || _unloading) then {

    if (_standby) then {
        _timer = +KPLIB_timers_default;
        _endpoints = [];
    };

    if (_unloading) then {
        _timer = [KPLIB_param_logistics_transportLoadTimeSeconds] call KPLIB_fnc_timers_create;
        _endpoints = [_endpoints] call KPLIB_fnc_logistics_swapEndpoints;
    };

    [_namespace, [
        [KPLIB_logistics_timer, _timer]
        , ["KPLIB_logistics_endpoints", _endpoints]
    ]] call KPLIB_fnc_namespace_setVars;
};

if (_debug) then {
    [format ["[fn_logisticsCO_onAbortLoading] Fini: [_standby, _unloading, _timer, _endpoints apply {_x#1}]: %1"
        , str [_standby, _unloading, _timer, _endpoints apply {_x#1}]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
