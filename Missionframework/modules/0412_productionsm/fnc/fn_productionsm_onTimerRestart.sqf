/*
    KPLIB_fnc_productionsm_onTimerRestart

    File: fn_productionsm_onTimerRestart.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 11:06:43
    Last Update: 2021-02-22 11:06:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Resets the CBA production namespace production timer.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _duration - the duration, in seconds, to use in the timer restart [SCALAR, default: KPLIB_param_production_leadTime]

    Returns:
        When the event handler is finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_duration", KPLIB_param_production_leadTime, [0]]
];

[
    [
        "KPLIB_param_productionsm_timer_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_timer_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", ""];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

private _timerThreshold = [_namespace] call KPLIB_fnc_productionsm_getProductionTimerThreshold;

if (_timerThreshold > 0) then {
    _duration = _timerThreshold;
};

private _restartedTimer = [_duration] call KPLIB_fnc_timers_create;
_namespace setVariable ["_timer", _restartedTimer];

if (_debug) then {
    [format ["[fn_productionsm_onTimerRestart] Timer restarted: [_markerName, _baseMarkerText, _timerThreshold, _duration, _restartedTimer]: %1"
        , str [_markerName, _baseMarkerText, _timerThreshold, _duration, _restartedTimer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
