/*
    KPLIB_fnc_timers_invert

    File: fn_timers_invert.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 22:54:49
    Last Update: 2021-03-09 22:54:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Inverts the timer. By this we mean, if duration D was X seconds in, then we
        determine the difference D-X, and use that instead. On the surface this can
        be as easy as reversing the _elapsedTime and _timeRemaining, but remember we
        must also account for that difference in the _startTime for the calculations
        to remain valid moving forward.

    Parameter(s):
        _duration - the estimated duration of the timer [SCALAR, default: KPLIB_timers_disabled]
        _startTime - the start time [SCALAR, default: 0]
        _elaspedTime - the period which has occurred since the timer started [SCALAR, default: 0] [1]
        _timeRemaining - the time remaining [SCALAR, default: 0] [1]

    Returns:
        An inverted version of the given TIMER.
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
];

if (_duration < 0) exitWith { +KPLIB_timers_default; };

// Which then also needs to REBASE in order for the TIMER calibration to be correct once again
[_duration, _startTime, _timeRemaining, _elapsedTime] call KPLIB_fnc_timers_rebase;
// Swap these two:      ^^^^^^^^^^^^^^  ^^^^^^^^^^^^
