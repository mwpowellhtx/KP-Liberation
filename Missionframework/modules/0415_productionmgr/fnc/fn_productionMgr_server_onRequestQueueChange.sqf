/*
    KPLIB_fnc_productionMgr_server_onRequestQueueChange

    File: fn_productionMgr_server_onRequestQueueChange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 20:59:47
    Last Update: 2021-02-10 20:59:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onRequestQueueChange' event handler, responds to the
        'KPLIB_productionMgr_onRequestQueueChange' CBA server event. Responds with
        the 'KPLIB_productionMgr_onProductionElemResponse' owner (i.e. client) event.

        More specifically, the change request process takes into consideration
        a few basic criteria:

            1. whether queue depth is permissible given the settings
            2. whether the array itself changed
            3. and whether candidate queue aligned with production cap
            4. changes to the pending element requires a reset in the timer

    Parameter(s):
        _markerName - the factory sector '_markerName' receiving the change request [STRING, default: ""]
        _candidateQueue - the '_productionElem' '_candidateQueue' encompassing the desired change [ARRAY, default: []]
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_markerName", "", [""]]
    , ["_candidateQueue", [], [[]]]
    , ["_cid", -1, [0]]
];

// TODO: TBD: review "exitWith {}" blocks: error log? client report? we think probably, TBD yet...

if (_debug) then {
    [format ["[fn_productionMgr_server_onRequestQueueChange] Entering: [_markerName, _candidateQueue, _cid]: %1"
        , str [_markerName, _candidateQueue, _cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// 1. Reject based on the queue depth already reached
if (count _candidateQueue > KPLIB_param_production_maxQueueDepth) exitWith {
    [format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_QUEUEDEPTH"
        , KPLIB_param_production_maxQueueDepth]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
};

// TODO: TBD: we'll start here, but we think we can accommodate callbacks into an FSM eventually...
private _production = KPLIB_production select {
    (_x#0#0) isEqualTo _markerName;
};

if (_production isEqualTo []) exitWith {
    // Could not match.
    // TODO: TBD: error log? client report?
    [format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_SECTORNOTFOUND"
        , _markerName]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
};

private _productionElem = (_production#0);

+(_productionElem#2) params [
    ["_cap", [], [[]], 3]
    , ["_totals", [], [[]], 3] // unused but we will verify it nonetheless
    , ["_currentQueue", [], [[]]]
];

_currentQueue = +_currentQueue;

// 2. No change, no need to notify anything
if (_candidateQueue isEqualTo _currentQueue) exitWith {
};

if (!((_candidateQueue select {_cap#_x}) isEqualTo _candidateQueue)) exitWith {
    // Insufficient factory sector capability to support request
    // TODO: TBD: error log? client report?
    [format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_INSUFFICIENTCAP"
        , (_productionElem#0#1)]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
};

// TODO: TBD: verify that this is actually the case...
// TODO: TBD: and might also trigger a save when that occurs...
// Which, we think, SHOULD, be injecting that adjustment in the parent KPLIB array
_productionElem#2 set [KPLIB_production_info_i_queue, +_candidateQueue];

// 4. Reset the timer when the resource type has been changed
if (!(_candidateQueue#0 isEqualTo _currentQueue#0)) then {
    // TODO: TBD: reset some timers, when we get there with a running FSM...
    // TODO: TBD: i.e. we would not take the default, but would actually create one afresh...
    // TODO: TBD: and using the prod lead time params... i.e. 'KPLIB_param_production_leadTime'
    _productionElem set [KPLIB_production_i_timer, +KPLIB_timers_default];
};

[] call KPLIB_fnc_init_save;

// Respond to the server request with this specific element only...
["KPLIB_productionMgr_onProductionElemResponse", _productionElem, _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[fn_productionMgr_server_onRequestQueueChange] Finished: [_markerName, _cid]: %1"
        , str [_markerName, _cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
