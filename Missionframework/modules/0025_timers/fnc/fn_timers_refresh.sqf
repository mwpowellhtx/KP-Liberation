/*
    KPLIB_fnc_timers_refresh

    File: fn_timers_refresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:24:17
    Last Update: 2021-02-03 15:24:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Refreshes the timer tuple. The algorithm is unit agnostic, however, in practice,
        all units are in terms of seconds. Furnish individual arguments or an entire
        timer shape, including optional Time Now component.

    Parameter(s):
        May be invoked with the _timer tuple itself as the arguments array:
        _timer - as the entire function args: i.e. [KPLIB_timers_disabled, KPLIB_timers_disabled, 0, 0]
            _duration - literally the timer duration, negative to disable [SCALAR, default: KPLIB_timers_disabled]
            _startTime - the time when the timer started [SCALAR, default: KPLIB_timers_disabled]
            _elapsedTime - the epalsed time since the timer started [SCALAR, default: 0]
            _timeRemaining - the estimated time remaining [SCALAR, default: 0]
            _now - not technically part of the _timer tuple, we allow for a _now component, which informs
                the current ([] call KPLIB_fnc_timers_now) while performing the necessary creation [SCALAR, default: ([] call KPLIB_fnc_timers_now)]
                i.e. [KPLIB_timers_disabled, KPLIB_timers_disabled, 0, 0, [] call KPLIB_fnc_timers_now]

    Returns:
        The timer tuple in the form:
            [
                _duration
                , _startTime
                , _elapsedTime
                , _timeRemaining
            ]
        When _duration is negative, returns with a disabled timer: [KPLIB_timers_disabled, 0, 0, 0]
        When _startTime is negative, allows the timer to be recalibrated by the current ([] call KPLIB_fnc_timers_now)

    Examples:
        (_timer call KPLIB_fnc_timers_refresh)
        Where _timer is a timer tuple in the shape of:
            [
                "_duration"
                , "_startTime"
                , "_elapsedTime"
                , "_timeRemaining"
            ]
        When recalibrating, i.e. ([_timer#0, nil, _timer#2, _timer#3] call KPLIB_fnc_timers_refresh)
        When creating a timer afresh, i.e. (call KPLIB_fnc_timers_refresh)
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", KPLIB_timers_disabled, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

// Nothing to refresh when the timer has not started
if (_duration < 0) exitWith {+KPLIB_timers_default};

if (_startTime <= 0) then {_startTime = _now};

_elapsedTime = _now - _startTime;

[_duration, _startTime, _elapsedTime, _duration - _elapsedTime];
