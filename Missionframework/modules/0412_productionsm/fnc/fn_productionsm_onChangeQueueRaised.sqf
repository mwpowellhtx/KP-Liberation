/*
    KPLIB_fnc_productionsm_onChangeQueueRaised

    File: fn_productionsm_onChangeQueueRaised.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 12:17:17
    Last Update: 2021-02-18 12:17:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback used to close the loop on the 'KPLIB_productionsm_raiseChangeQueue'
        client server CBA production statemachine request.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _queue - the current '_queue' value [ARRAY, default: []]
        _newQueue - the current '_newQueue' value [ARRAY, default: []]
        _cid - the client identifier [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_changeOrders_debug"
        , "KPLIB_param_productionsm_raise_debug"
        , "KPLIB_param_productionsm_raiseChangeQueue_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_queue", [], [[]]]
    , ["_newQueue", [], [[]]]
    , ["_cid", -1, [0]]
];

private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _capability = _namespace getVariable ["_capability", KPLIB_production_cap_default];
private _previousQueue = _namespace getVariable ["_previousQueue", []];
private _queueDepth = KPLIB_param_production_maxQueueDepth;

if (_debug) then {
    [format ["[fn_productionsm_onChangeQueueRaised] Entering: [_markerName, _queue, _newQueue, _capability, _cid]: %1"
        , str [_markerName, _queue, _newQueue, _capability, _cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _onExitWith = {
    params [
        ["_retval", [], [[]]]
        , ["_msg", "", [""]]
    ];
    if (_debug) then {
        [format ["[fn_productionsm_onChangeQueueRaised] %1", _msg], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    _retval;
};

private _noChange = _newQueue isEqualTo _queue;
private _capable = _newQueue select { _capability select _x; };

if (_noChange) exitWith {
    [_queue, localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_NO_CHANGE"] call _onExitWith;
};

if (count _newQueue > _queueDepth) exitWith {
    [_queue, format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_QUEUEDEPTH", _queueDepth]] call _onExitWith;
};

if (!(_capable isEqualTo _newQueue)) exitWith {
    [_queue, format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_INSUFFICIENTCAP", _baseMarkerText]] call _onExitWith;
};

if (_debug) then {
    [format ["[fn_productionsm_onChangeQueueRaised] Finished: [_queue, _newQueue]: %1"
        , str [_queue, _newQueue]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

/* Keep hold of the old value for evaluation during the next Scheduler phase. Which the Scheduler
 * will use to evaluate how to effect changes, if any, to the respective production '_timer'. */

_namespace setVariable ["_previousQueue", _queue];

_newQueue;
