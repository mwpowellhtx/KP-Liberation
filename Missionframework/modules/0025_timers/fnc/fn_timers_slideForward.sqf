/*
    KPLIB_fnc_timers_slideForward

    File: fn_timers_slideForward.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:35:28
    Last Update: 2021-02-03 15:35:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the time is approaching the elapsed moment within a given buffer zone.

    Parameter(s):
        _duration - the timer duration [SCALAR, default: nil]
        _startTime - the time when the timer started [SCALAR, default: nil]
        _elapsedTime - the epalsed time since the timer started [SCALAR, default: nil]
        _timeRemaining - the estimated time remaining [SCALAR, default: nil]
        _now - a time component used to initialize the timer [SCALAR, default: ([] call KPLIB_fnc_timers_now)]

    Returns:
        A timer tuple in the form:
            [
                _duration
                , _startTime
                , _elapsedTime
                , _timeRemaining
            ]

    References:
        [1] ignored for purposes of this function except to maintain the shape of the timer
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", KPLIB_timers_disabled, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

if (_duration < 0) exitWith {+KPLIB_timers_default};

// Remember that the delta must account for the elapsed time since the timer started
private _delta = _now - _startTime + _elapsedTime;

// Nothing else should change here, just push the start time forward a smidge
[_duration, _startTime + _delta, _elapsedTime, _timeRemaining];
