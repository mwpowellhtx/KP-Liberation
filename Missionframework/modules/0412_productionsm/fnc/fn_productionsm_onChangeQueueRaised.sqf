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
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_queue", [], [[]]]
    , ["_newQueue", [], [[]]]
    , ["_cid", -1, [0]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _capability = _namespace getVariable ["_capability", KPLIB_production_cap_default];

if (_debug) then {
    [format ["[fn_productionsm_onChangeQueueRaised] Entering: [_markerName, _queue, _newQueue, _capability, _cid]: %1"
        , str [_markerName, _queue, _newQueue, _capability, _cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[
    _newQueue isEqualTo _queue
    , (count _newQueue) isEqualTo (count _capability)
    , (_newQueue select { _capability select _x; }) isEqualTo _newQueue
] params [
    "_noChange"
    , "_sizeEqual"
    , "_capVerified"
];

// TODO: TBD: no change, nothing to report...
if (_noChange) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onChangeQueueRaised] Finished: [_noChange]: %1"
            , str [_noChange]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

// TODO: TBD: send '_cid' notification when something is wrong about the queue...
if (!(_sizeEqual || _capVerified)) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onChangeQueueRaised] Finished: [_sizeEqual, _capVerified]: %1"
            , str [_sizeEqual, _capVerified]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

/* Keep hold of the old value for evaluation during the next Scheduler phase. Which the Scheduler
 * will use to evaluate how to effect changes, if any, to the respective production '_timer'. */

_namespace setVariable ["_previousQueue", (+_queue)];
_namespace setVariable ["_queue", (+_newQueue)];

true;
