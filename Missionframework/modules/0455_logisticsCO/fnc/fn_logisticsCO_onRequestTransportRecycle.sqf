/*
    KPLIB_fnc_logisticsCO_onRequestTransportRecycle

    File: fn_logisticsCO_onRequestTransportRecycle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 12:06:32
    Last Update: 2021-03-01 12:06:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Logistics manager requests line transport be built.

    Parameters:
        _targetUuid - the target logistics line UUID for which to build convoy transport [STRING, default: ""]
        _targetFobMarker - the target FOB marker in proximity to the player [STRING, default: ""]
        _cid - the client identifier originating the request [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/pushBack
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onRequestTransportRecycle_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_targetUuid", "", [""]]
    , ["_targetFobMarker", "", [""]]
    , ["_cid", -1, [0]]
];

// TODO: TBD: may message when namespace is null for any reason...
private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestTransportRecycle] Entering: [_targetUuid, _targetFobMarker, isNull _namespace, _cid]: %1"
        , str [_targetUuid, _targetFobMarker, isNull _namespace, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

if (isNull _namespace || _cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onRequestTransportRecycle] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _onInitializeChangeOrder = {
    params ["_changeOrder"];

    [_changeOrder, [
        ["KPLIB_logistics_targetUuid", _targetUuid]
        , ["KPLIB_logistics_targetFobMarker", _targetFobMarker]
        , ["KPLIB_logistics_cid", _cid]
        , ["KPLIB_changeOrder_onChangeOrder", KPLIB_fnc_logisticsCO_onTransportRecycle]
        , ["KPLIB_changeOrder_onChangeOrderEntering", KPLIB_fnc_logisticsCO_onTransportRecycleEntering]
    ]] call KPLIB_fnc_namespace_setVars;

};

// Enqueue the CHANGE ORDER and get out of the way ASAP
private _changeOrder = [_onInitializeChangeOrder] call KPLIB_fnc_changeOrders_create;

// This is it, enqueue the change order and get out of the way ASAP
private _enqueued = [_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue;

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestTransportRecycle] Fini: [isNull _changeOrder, _enqueued]: %1"
        , str [isNull _changeOrder, _enqueued]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

_enqueued;
