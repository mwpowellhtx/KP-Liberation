/*
    KPLIB_fnc_timers_hasElapsed

    File: fn_timers_hasElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:35:28
    Last Update: 2021-02-03 15:35:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the timer has elapsed.

    Parameter(s):
        _duration - the estimated duration of the timer [SCALAR, default: KPLIB_timers_disabled]
        _startTime - the start time [SCALAR, default: 0]
        _elaspedTime - the period which has occurred since the timer started [SCALAR, default: 0] [1]
        _timeRemaining - the time remaining [SCALAR, default: 0] [1]
        _now - the time around which elaspsed is considered [SCALAR, default: ([] call KPLIB_fnc_timers_now)]

    Returns:
        Whether the timer has elapsed.

    References:
        [1] ignored for purposes of this function except to maintain the shape of the timer
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

if (_duration < 0 || _timeRemaining > 0) exitWith {false};

// Timers cannot have elapsed when they are not running
private _elapsedTimeNow = _now - _startTime;

_duration >= 0 && _elapsedTimeNow >= _duration;
