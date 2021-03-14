/*
    KPLIB_fnc_logisticsCO_onRequestMissionConfirm

    File: fn_logisticsCO_onRequestMissionConfirm.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 12:14:20
    Last Update: 2021-03-14 18:12:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client logistics manager requests mission confirmation. For now we assume that
        the manager did its routine due diligence and quality control approaching the
        request. We will do a minimal amount of verification, enough to proceed and
        setup status, timer, and present the endpoints themselves. Refer to references
        concerning '_cid' for player- versus SM-driven requests.

    Parameters:
        _lineUuid - the logistics LINE UUID for which to confirm its mission [STRING, default: ""]
        _endpoints - the ENDPOINTS submitted for confirmation [ARRAY, default: []]
        _cid - the client identifier used to notify of the outcome [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Multiplayer_Scripting#Machine_network_ID
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onRequestMissionConfirm_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_targetUuid", "", [""]]
    , ["_endpoints", [], [[]]]
    , ["_cid", -1, [0]]
];

private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;

// Must have a corresponding LOGISTIC LINE first and foremost
if (isNull _namespace) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionConfirm] %1: [isNull _namespace]: %2"
            , localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_CONFIRM"
            , str [isNull _namespace]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [
            localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_CONFIRM"
        ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    false;
};

_endpoints params [
    ["_alpha", []]
    , ["_bravo", []]
];

// Assuming also the LOGISTICS MANAGER did some due diligance and QC...
private _verified = [_alpha, _bravo] apply {
    ([_x] call KPLIB_fnc_logistics_verifyEndpoint);
};

if (({ _x; } count _verified) != 2) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onRequestMissionConfirm] %1: [_verified, _endpoints]: %2"
            , localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_CONFIRM"
            , str [_verified, _endpoints]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [
            localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_CONFIRM"
        ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };

    false;
};

// May proceed scheduling the CHANGE ORDER...
private _onInitializeChangeOrder = {
    [_this, [
        ["KPLIB_logistics_targetUuid", _targetUuid]
        , ["KPLIB_logistics_endpoints", _endpoints]
        , ["KPLIB_logistics_cid", _cid]
        , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_logisticsCO_onMissionConfirm]
        , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_logisticsCO_onMissionConfirmEntering]
    ]] call KPLIB_fnc_namespace_setVars;
};

private _changeOrder = [_onInitializeChangeOrder] call KPLIB_fnc_changeOrders_create;

// TODO: TBD: there may be variables defined with the key CIDs...
private _confirmedOrConfirming = if (_cid < 0) then {
    // Server side automated change overs are processed IMMEDIATELY
    [_namespace, _changeOrder, true] call KPLIB_fnc_changeOrders_processOne;
} else {
    // Whereas genuine client requests are submitted to the CHANGE ORDER QUEUE
    [_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue
};

if (_debug) then {
    // TODO: TBD: add logging...
};

_confirmedOrConfirming;
