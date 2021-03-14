/*
    KPLIB_fnc_logisticsCO_onRequestMissionReroute

    File: fn_logisticsCO_onRequestMissionReroute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 16:34:54
    Last Update: 2021-03-13 16:34:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client logistics manager requests server side mission be REROUTED. Effectively,
        this is in response to the line having falling into an ABANDONED status, in which
        one or both of its ENDPOINTS are determined to no longer be valid ENDPOINT
        candidates, and so, the line froze EN_ROUTE, and must be rerouted.

    Parameters:
        _targetUuid - the target LOGISTIC LINE UUID for which to REROUTE its mission [STRING, default: ""]
        _cid - the client identifier used to notify of the outcome [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

// TODO: TBD: separate this out into change order protocols...
private _debug = [
    [
        {KPLIB_param_logisticsCO_onRequestMissionReroute_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_targetUuid", "", [""]]
    , ["_cid", -1, [0]]
];

private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;

if (isNull _namespace) exitWith {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_REROUTE";
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionReroute] %1: [isNull _namespace]: %2"
            , _msg, str [isNull _namespace]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    false;
};

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

// Line cannot be rerouted, but this is not an "error" per se
if (_status == KPLIB_logistics_status_standby) exitWith {
    true;
};

/* The request should not be here, but indicate when we are anyway,
 * cannot REROUTE a mission that is determined not to be ABANDONED */
if (!([_status, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_checkStatus)) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionReroute] %1"
            , localize "STR_KPLIB_LOGISTICS_MSG_MISSION_NOT_ABANDONED"], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [
            localize "STR_KPLIB_LOGISTICS_MSG_MISSION_NOT_ABANDONED"
        ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    true;
};

/* ABANDONED lines may still fall under AMBUSH especially when they linger,
 * at which point are no longer recoverable, AMBUSH must be followed through */
if ([_status, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionReroute] %1"
            , localize "STR_KPLIB_LOGISTICS_MSG_MISSION_AMBUSHED"], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [
            localize "STR_KPLIB_LOGISTICS_MSG_MISSION_AMBUSHED"
        ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    true;
};

// May proceed scheduling the CHANGE ORDER...
private _onInitializeChangeOrder = {
    [_this, [
        ["KPLIB_logistics_targetUuid", _targetUuid]
        , ["KPLIB_logistics_cid", _cid]
        , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_logisticsCO_onMissionReroute]
        , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_logisticsCO_onMissionRerouteEntering]
    ]] call KPLIB_fnc_namespace_setVars;
};

private _changeOrder = [_onInitializeChangeOrder] call KPLIB_fnc_changeOrders_create;
private _enqueued = [_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue;

if (_debug) then {
    // TODO: TBD: add logging...
};

_enqueued;
