/*
    KPLIB_fnc_timers_fastForward

    File: fn_timers_fastForward.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:35:28
    Last Update: 2021-02-03 15:35:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Fast forwards the timer given the delta time in seconds. Difference between
        sliding forward and fast forwarding. We slide forward given the 'serverTime',
        where as we fast foward by a given '_delta' of time.

    Parameter(s):
        _duration - the timer duration, remains unchanged [SCALAR, default: KPLIB_timers_disabled]
        _startTime - the start time [SCALAR, default: 0]
        _elapsedTime - the elapsed time in seconds [SCALAR, default: 0]
        _timeRemaining - the time remaining in seconds [SCALAR, default: 0]
        _delta - the time, in seconds, to fast forward [SCALAR, default: 0]
        _now - the baseline time now [SCALAR, default: ([] call KPLIB_fnc_timers_now)]

    Returns:
        A fast forwarded version of the timer [TIMER, default: (+KPLIB_timers_default)]

    References:
        [1] ignored for purposes of this function except to maintain the shape of the timer
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
    , ["_delta", 0, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

if (_duration < 0) exitWith {+KPLIB_timers_default};

// So that fast forward is fast forward
_delta = abs _delta;

// Somewhat counter-intuitive, knock time off from the '_startTime'
_startTime = _startTime - _delta;

// Then recalibrate, recalculate '_elapsedTime' and '_timeRemaining'
_elapsedTime = _now - _startTime;
_timeRemaining = _duration - _elapsedTime;

// The calculations are pretty straightforward, so no need to make any further calls
[_duration, _startTime, _elapsedTime, _timeRemaining];
