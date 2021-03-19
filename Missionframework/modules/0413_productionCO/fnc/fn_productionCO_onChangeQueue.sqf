/*
    KPLIB_fnc_productionCO_onChangeQueue

    File: fn_productionCO_onChangeQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 12:17:17
    Last Update: 2021-03-17 13:06:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Completes the CHANGE QUEUE change order following verification on entering.

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
        {KPLIB_param_productionCO_onChangeQueue_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onChangeQueue_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_onChangeQueue_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

if (_debug) then {
    [format ["[fn_productionCO_onChangeQueue] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_production_markerName", ""]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_queue", []]
    , ["KPLIB_production_timer", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
    , "_queue"
    , "_timer"
];

([_changeOrder, [
    ["KPLIB_production_cid", -1]
    , ["KPLIB_production_queueCandidate", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
    , "_queueCandidate"
];

private _lastResource = -1;

// TODO: TBD: borderline, establish a shared function for this one...
// TODO: TBD: that, and/or we leverage the change queue change order when the queue changes between productions...
_timer = ([_timer] + [
    [_queue, _lastResource] call KPLIB_fnc_linq_first
    , [_queueCandidate, _lastResource] call KPLIB_fnc_linq_first
]) call {
    params [
        ["_timer", +KPLIB_timers_default, [[]], 4]
        // Not to be confused with endpoints, but for shorthand below...
        , ["_alpha", _lastResource, [0]]
        , ["_bravo", _lastResource, [0]]
    ];

    private _running = _timer call KPLIB_fnc_timers_isRunning;

    switch (true) do {
        case (_bravo >= 0 && _alpha == _bravo): { +_timer; };
        case (_bravo >= 0 && _alpha != _bravo): {
            private _duration = [_namespace] call KPLIB_fnc_productionSM_getProductionTimerDuration;
            [_duration] call KPLIB_fnc_timers_create;
        };
        default { +KPLIB_timers_default; };
    };
};

if (_debug) then {
    [format ["[fn_productionCO_onChangeQueue] Changing: [_markerName, _baseMarkerText, _timer, _queue, _queueCandidate, _cid]: %1"
        , str [_markerName, _baseMarkerText, _timer, _queue, _queueCandidate, _cid]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

[_namespace, [
    ["KPLIB_production_queue", +_queueCandidate]
    , ["KPLIB_production_timer", +_timer]
]] call KPLIB_fnc_namespace_setVars;

// // TODO: TBD: already messaged during the "entering" callback...
// if (_cid > 0) then {
//     [format [localize "STR_KPLIB_PRODUCTIONMGR_NOTIFICATION_FORMAT_CHANGED", _baseMarkerText]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
// };

if (_debug) then {
    ["[fn_productionCO_onChangeQueue] Fini", "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true;
