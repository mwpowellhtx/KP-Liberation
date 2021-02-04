/*
    KPLIB_fnc_timers_isApproaching

    File: fn_timers_isApproaching.sqf
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
        _elapsedTime - the epalsed time since the timer started [SCALAR, default: nil] [1]
        _timeRemaining - the estimated time remaining [SCALAR, default: nil] [1]
        _elapsedWindow - a buffer zone used to determine whether the timer is approaching elapsed [SCALAR, default: nil]
        _now - the time now upon which to gauge approaching [SCALAR, default: ([] call KPLIB_fnc_timers_now)]

    Returns:
        Whether the time is approaching the elapsed moment within a given buffer zone.

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

/* Like the function says, this is asking whether the timer is "approaching" the destination
 * as it was time estimated. It does not ask whether the timer is near the point of origin. */

// Assumes that start time is properly calibrated against 'serverTime'
(_now + _elapsedWindow) >= (_startTime + _duration);
