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
    ["KPLIB_logistics_uuid", ""]
    , [KPLIB_logistics_timer, []]
    , [KPLIB_changeOrders_orders, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_beforeTimer"
    , "_changeOrders"
];

_beforeTimer = +_beforeTimer;

// Optionally insert standing CHANGE ORDER: line EN ROUTE and potentially BLOCKED
[KPLIB_param_logistics_routesCanBeBlocked] call {
    params ["_canBeBlocked"];

    if (!_canBeBlocked) exitWith {};

    private _onInitializeChangeOrder = {
        params ["_changeOrder"];

        [_changeOrder, [
            ["KPLIB_logistics_targetUuid", _targetUuid]
            , ["KPLIB_changeOrder_onChangeOrder", KPLIB_fnc_logisticsCO_onMissionBlocked]
            , ["KPLIB_changeOrder_onChangeOrderEntering", KPLIB_fnc_logisticsCO_onMissionBlockedEntering]
        ]] call KPLIB_fnc_namespace_setVars;
    };

    private _changeOrder = [_onInitializeChangeOrder] call KPLIB_fnc_changeOrders_create;

    private _inserted = [_namespace, [_changeOrder]] call KPLIB_fnc_changeOrders_insert;

    if (_debug) then {
        [format ["[fn_logisticsSM_onPending::onCanBeBlocked] [_targetUuid, _inserted]: %1"
            , str [_targetUuid, _inserted]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
};

[_namespace] call KPLIB_fnc_changeOrders_process;

[
    [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logisticsSM_checkStatus
    , [_namespace, KPLIB_logistics_status_routeBlocked] call KPLIB_fnc_logisticsSM_checkStatus
    , [_namespace, KPLIB_logistics_status_aborting] call KPLIB_fnc_logisticsSM_checkStatus
] params [
    "_ambushed"
    , "_routeBlocked"
    , "_aborting"
];

if (_debug) then {
    [format ["[fn_logisticsSM_onPending] Entering: [count _changeOrders, _ambushed, _routeBlocked, _aborting, _beforeTimer]: %1"
        , str [count _changeOrders, _ambushed, _routeBlocked, _aborting, _beforeTimer]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    [KPLIB_logistics_timer, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_changeOrdersTimer"
];

_changeOrdersTimer = +_changeOrdersTimer;

// TODO: TBD: without getting too nuts in the heuristics of when to (block || !block), abort, etc
// Allowing for timer movement when...
if ((_aborting && !_ambushed) || !(_ambushed || _routeBlocked)) then {
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
