/*
    KPLIB_fnc_timers_create

    File: fn_timers_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:24:17
    Last Update: 2021-02-03 15:24:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a fresh timer tuple given the default _duration and _now time marker.

    Parameter(s):
        _duration -
        _now - the moment when the timer was created

    Returns:
        The timer tuple in the form:
            [
                _duration
                , _startTime
                , _elapsedTime
                , _timeRemaining
            ]
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_now", [] call KPLIB_fnc_timers_now, [0]]
];

private _elapsedTime = 0;

[
    _duration
    , _now
    , _elapsedTime
    , if (_duration < 0) then {0} else {_duration - _elapsedTime}
];
