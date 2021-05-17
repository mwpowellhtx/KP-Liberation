/*
    KPLIB_fnc_productionCO_onChangeQueueEntering

    File: fn_productionCO_onChangeQueueEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 12:17:17
    Last Update: 2021-03-17 12:33:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Evaluates the state of the CHANGE ORDER as compared with the state of the PRODUCTION
        namespace in order to determine whether the change order should proceed. Performs a
        much deeper analysis of the conditions than the initial request did in order to
        determine whether to proceed and simply accept the change.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA CHANGE ORDER namespace [LOCATION, default: locationNull]
            "KPLIB_production_cid" - the client owner making the request [SCALAR, default: -1]
            "KPLIB_production_queueCandidate" - the queue candidate being considered [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionCO_onChangeQueueEntering_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onChangeQueueEntering_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_onChangeQueueEntering_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

if (_debug) then {
    [format ["[fn_productionCO_onChangeQueueEntering] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_queue", []]
    , ["KPLIB_production_maxQueueDepth", KPLIB_param_production_maxQueueDepth]
    , ["KPLIB_production_capability", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
    , "_queue"
    , "_maxQueueDepth"
    , "_capability"
];

([_changeOrder, [
    ["KPLIB_production_cid", -1]
    , ["KPLIB_production_queueCandidate", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
    , "_queueCandidate"
];

// Ensures that queue depth is at least one (1)
_maxQueueDepth = _maxQueueDepth max 1;

if (_debug) then {
    [format ["[fn_productionCO_onChangeQueueEntering] Evaluating: [_markerName, _queue, _queueCandidate, _maxQueueDepth, _capability, _cid]: %1"
        , str [_markerName, _queue, _queueCandidate, _maxQueueDepth, _capability, _cid]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

private _onExitWith = {
    params [
        ["_condition", false, [false]]
        , ["_retval", false, [false]]
        , ["_callback", {""}, [{}]]
    ];
    if (_debug) then {
        [format ["[fn_productionCO_onChangeQueueEntering] %1", _msg], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
    };
    if (_cid > 0) then {
        private _msg = [] call _callback;
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
    _retval;
};

private _response = [
    [
        // No change
        _queueCandidate isEqualTo _queue
        , false
        , {localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_NO_CHANGE"}
    ]
    , [
        // Queue maximum depth exceeded
        count _queueCandidate > _maxQueueDepth
        , false
        , {format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_QUEUE_DEPTH", _maxQueueDepth]}
    ]
    , [
        // Insufficient capability to support the requested queue
        !((_queueCandidate select { _capability select _x; }) isEqualTo _queueCandidate)
        , false
        , {format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_CAP_INSUFFICIENT", _baseMarkerText]}
    ]
    , [
        // Otherwise success: proceed to change queue
        true
        , true
        , {format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_CHANGED", _baseMarkerText]}
    ]
] select { (_x#0); };


if (_debug) then {
    [format ["[fn_productionCO_onChangeQueueEntering] Fini: [_queue, _queueCandidate]: %1"
        , str [_queue, _queueCandidate]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

(_response#0) call _onExitWith;
