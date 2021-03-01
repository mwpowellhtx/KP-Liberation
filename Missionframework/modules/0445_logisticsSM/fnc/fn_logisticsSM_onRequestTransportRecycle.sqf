// TODO: TBD: we may be able to leverage the transport build/recycle pattern here...
//      1. assess debit/credit
//      2. pay debit/refund credit
//      3. finalize
/*
    KPLIB_fnc_logisticsSM_onRequestTransportRecycle

    File: fn_logisticsSM_onRequestTransportRecycle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 12:06:32
    Last Update: 2021-03-01 15:07:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Logistics manager requests line transport be recycled.

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
        {KPLIB_logisticsSM_onRequestTransportRecycle_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_targetUuid", "", [""]]
    , ["_targetFobMarker", "", [""]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestTransportRecycle] Entering: [_targetUuid, _targetFobMarker, _cid]: %1"
        , str [_targetUuid, _targetFobMarker, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onRequestTransportRecycle] Invalid client identifier: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private ["_msg", "_args"];

// TODO: TBD: would be stronger if we also tracked: [_valueattimeofbuild, _cost] for more accurate recycle logistics...
private _namespace = [_lineUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;
private _status = _namespace getVariable ["KPLIB_logistics_status", KPLIB_logistics_status_standby];
private _convoy = _namespace getVariable ["KPLIB_logistics_convoy", []];
private _convoyIndex = _convoy findIf { _x isEqualTo KPLIB_resources_storageValueDefault; };

if (_convoyIndex < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onRequestTransportRecycle] Convoy empty: [_targetUuid, _targetFobMarker, _convoyIndex, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _convoyIndex, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_RECYCLE_EMPTY";
    [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    false;
};

if (!(_status == KPLIB_logistics_status_standby
    || [_status, KPLIB_logistics_status_loadingUnloading] call BIS_fnc_bitflagsCheck)) exitWith {

    private _statusReport = [_status] call KPLIB_fnc_logistics_getStatusReport;

    if (_debug) then {
        [format ["[fn_logisticsSM_onRequestTransportRecycle] Status prohibits request or convoys are all occupied: [_targetUuid, _targetFobMarker, _convoyIndex, '_statusReport', _status, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _convoyIndex, ["'", "'"] joinString _statusReport, _status, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };

    _msg = format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_CANNOT_RECYCLE", _statusReport];
    [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    false;
};

private _credit = [] call KPLIB_fnc_logisticsSM_getTransportCredit;

private _credited = true;

if (!(_credit isEqualTo KPLIB_resources_storageValueDefault)) then {

    private _creditArgs = +([_targetFobMarker, _credit] call { [(_this#0)] + (_this#1); });
    //                                               location:  ^^^^^^^^^

    _credited = _creditArgs call KPLIB_fnc_resources_refund;
};

if (!_credited) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onRequestTransportRecycle] Insufficient space: [_targetUuid, _targetFobMarker, _credit, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _credit, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    // TODO: TBD: may further identify the FOB that has the insufficient space...
    _args = [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_INSUFFICIENT_SPACE"] + _credit;
    _msg = format _args;
    [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    false;
};

private _finalized = [_namespace, _credit, _convoyIndex, _cid] call {
    params [
        ["_namespace", locationNull, [locationNull]]
        , ["_credit", [], [[]], 3]
        , ["_convoyIndex", 0, [0]]
        , ["_cid", -1, [0]]
    ];

    private _convoy = _namespace getVariable ["KPLIB_logistics_convoy", []];
    //                                                                  ^^

    // May use the '_recycledTransport' for further diagnostics...
    private _recycledTransport = _convoy deleteAt _convoyIndex;

    // May not need to set it back again, but do so in the event there was a default get (^)
    _namespace setVariable ["KPLIB_logistics_convoy", _convoy];

    _args = [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_RECYCLED"] + _credit;
    _msg = format _args;
    [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    [] call KPLIB_fnc_logisticsSM_onBroadcastLines;

    true;
};

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestTransportRecycle] Fini: [_finalized]: %1"
        , str [_finalized]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_finalized;
