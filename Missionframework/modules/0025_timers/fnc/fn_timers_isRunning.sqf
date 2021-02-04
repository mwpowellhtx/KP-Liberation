/*
    KPLIB_fnc_timers_isRunning

    File: fn_timers_isRunning.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:37:56
    Last Update: 2021-02-03 15:37:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the timer may be considered installed.

    Parameter(s):
        _duration - the timer duration [SCALAR, default: nil]
        _startTime - the time when the timer started [SCALAR, default: nil] [1]
        _elapsedTime - the epalsed time since the timer started [SCALAR, default: nil] [1]
        _timeRemaining - the estimated time remaining [SCALAR, default: nil] [1]

    Returns:
        Whether the timer may be considered installed.

    References:
        [1] ignored for purposes of this function except to maintain the shape of the timer
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
];

/* We check duration and ignore start time, other than the boundary above, because start can be
 * negative, depending on whether server restart happened, timer rebasement occurred, etc. */

_duration >= 0;
