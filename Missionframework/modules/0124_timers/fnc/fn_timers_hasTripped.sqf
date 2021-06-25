/*
    KPLIB_fnc_timers_hasTripped

    File: fn_timers_hasTripped.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:35:28
    Last Update: 2021-06-25 15:11:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the timer tripped, that is, whether elapsed exceeded the window.

    Parameter(s):
        _duration - the timer duration [SCALAR, default: nil] [1]
        _startTime - the time when the timer started [SCALAR, default: nil]
        _elapsedTime - the epalsed time since the timer started [SCALAR, default: nil] [1]
        _timeRemaining - the estimated time remaining [SCALAR, default: nil] [1]
        _elapsedWindow - the period of time in which the timer may have tripped [SCALAR, default: 0]
        _now - the time now [SCALAR, default: ([] call KPLIB_fnc_timers_now)]

    Returns:
        Whether the timer tripped, that is, whether elapsed exceeded the window.

    References:
        [1] ignored for purposes of this function except to maintain the shape of the timer
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
    , ["_elapsedWindow", 0, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

if (_duration < 0) exitWith {false};

(_now - _startTime) >= _elapsedWindow;
