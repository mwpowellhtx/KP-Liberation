/*
    KPLIB_fnc_logisticsCO_onRequestMissionAbort

    File: fn_logisticsCO_onRequestMissionAbort.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 12:11:32
    Last Update: 2021-03-15 11:36:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client logistics manager requests server side mission ABORT. For now we
        assume that the manager did its routine due diligence and quality control
        approaching the request. We will do a minimal amount of verification, enough
        to proceed with the request.

    Parameters:
        _targetUuid - the target LOGISTIC LINE UUID for which to ABORT its mission [STRING, default: ""]
        _cid - the client identifier used to notify of the outcome [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

// TODO: TBD: separate this out into change order protocols...
private _debug = [
    [
        {KPLIB_param_logisticsCO_onRequestMissionAbort_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_targetUuid", "", [""]]
    , ["_cid", -1, [0]]
];

private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;

if (isNull _namespace) exitWith {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_ABORT";
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionAbort] %1: [isNull _namespace]: %2"
            , _msg, str [isNull _namespace]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    false;
};

[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
    , "_aborting"
    , "_ambushed"
];

// TODO: TBD: log and/or notify, line already on STANDBY or ABORTING
if (_standby) exitWith {
    true;
};

// Cannot ABORT a mission that is already ABORTING
if (_aborting) exitWith {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_ALREADY_ABORTING";
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionAbort] %1", _msg], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
    true;
};

// Cannot ABORT a mission that has fallen under AMBUSH
if (_ambushed) exitWith {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_AMBUSHED";
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionAbort] %1", _msg], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
    true;
};

// May proceed scheduling the CHANGE ORDER...
private _onInitializeChangeOrder = {
    [_this, [
        ["KPLIB_logistics_targetUuid", _targetUuid]
        , ["KPLIB_logistics_cid", _cid]
        , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_logisticsCO_onMissionAbort]
        , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_logisticsCO_onMissionAbortEntering]
    ]] call KPLIB_fnc_namespace_setVars;
};

private _changeOrder = [_onInitializeChangeOrder] call KPLIB_fnc_changeOrders_create;

// TODO: TBD: there may be variables defined with the key CIDs...
private _processedOrEnqueued = if (_cid < 0) then {
    // Server side automated change overs are processed IMMEDIATELY
    [_namespace, _changeOrder] call KPLIB_fnc_changeOrders_processOne;
} else {
    // Whereas genuine client requests are submitted to the CHANGE ORDER QUEUE...
    [_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue;
};

if (_debug) then {
    // TODO: TBD: add logging...
};

_processedOrEnqueued;
