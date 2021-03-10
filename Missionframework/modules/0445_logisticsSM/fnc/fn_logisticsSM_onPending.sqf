/*
    KPLIB_fnc_logisticsSM_onPending

    File: fn_logisticsSM_onPending.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 17:38:06
    Last Update: 2021-03-07 17:38:08
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
        {KPLIB_param_logisticsSM_onPending_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    [KPLIB_logistics_timer, []]
    , ["KPLIB_changeOrders", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_beforeTimer"
    , "_changeOrders"
];

_beforeTimer = +_beforeTimer;

[
    [_namespace, KPLIB_logistics_status_ambushedRouteBlocked] call KPLIB_fnc_logisticsSM_checkStatus
] params [
    "_ambushedOrRouteBlocked"
];

if (_debug) then {
    [format ["[fn_logisticsSM_onPending] Entering: [count _changeOrders, _ambushedOrRouteBlocked, _beforeTimer]: %1"
        , str [count _changeOrders, _ambushedOrRouteBlocked, _beforeTimer]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

[_namespace] call KPLIB_fnc_changeOrders_process;

([_namespace, [
    [KPLIB_logistics_timer, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_changeOrdersTimer"
];

_changeOrdersTimer = +_changeOrdersTimer;

// AMBUSHED+ROUTE_BLOCKED are the only status which 'pauses' the TIMER, everything else continues, even NO_SPACE+NO_RESOURCE
if (!_ambushedOrRouteBlocked) then {
    [_namespace] call KPLIB_fnc_logisticsSM_onRefreshTimer;
};

([_namespace, [
    [KPLIB_logistics_timer, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_refreshedTimer"
];

_refreshedTimer = +_refreshedTimer;

([_namespace, [
    [KPLIB_logistics_timer, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_afterTimer"
];

_afterTimer = +_afterTimer;

if (_debug) then {
    [format ["[fn_logisticsSM_onPending] Fini: [_beforeTimer, _changeOrdersTimer, _refreshedTimer, _afterTimer]: %1"
        , str [_beforeTimer, _changeOrdersTimer, _refreshedTimer, _afterTimer]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
