/*
    KPLIB_fnc_productionsm_onSchedulerEntered

    File: fn_productionsm_onSchedulerEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 10:53:12
    Last Update: 2021-02-22 10:53:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Mostly a no-op, but we use this phase of the Scheduler state in order to accelerate
        production time tables, especially while we are under development.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _threshold - [SCALAR, default: KPLIB_param_productionsm_productionTimerThresholdSecondsDebug]

    Returns:
        When the event handler is finished [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_scheduler_debug"
        , "KPLIB_param_productionsm_schedulerEntered_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

private _objSM = KPLIB_productionsm_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_threshold", KPLIB_param_productionsm_productionTimerThresholdSecondsDebug, [0]]
];

private _timer = _namespace getVariable ["_timer", []];
private _markerName = _namespace getVariable ["_markerName", ""];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

if (_debug) then {
    [format ["[fn_productionsm_onSchedulerEntered] Entering: [_markerName, _baseMarkerText, _timer, _threshold]: %1"
        , str [_markerName, _baseMarkerText, _timer, _threshold]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Fast forward the timer using the '_timeRemaining' delta adjusted by the '_threshold'
private _timeRemaining = (_timer#3);

if ((_timer call KPLIB_fnc_timers_isRunning)
    && _threshold > 0
    && _timeRemaining >= _threshold) then {

    private _fastForwardArgs = _timer + [abs (_timeRemaining - _threshold)];
    private _newTimer = _fastForwardArgs call KPLIB_fnc_timers_fastForward;

    if (_debug) then {
        [format ["[fn_productionsm_onSchedulerEntered] Timer fast forwarded: [_markerName, _baseMarkerText, _threshold, _delta, _timer, _newTimer]: %1"
            , str [_markerName, _baseMarkerText, _threshold, _delta, _timer, _newTimer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    _namespace getVariable ["_timer", (+_newTimer)];
};

if (_debug) then {
    ["[fn_productionsm_onSchedulerEntered] Fini", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
