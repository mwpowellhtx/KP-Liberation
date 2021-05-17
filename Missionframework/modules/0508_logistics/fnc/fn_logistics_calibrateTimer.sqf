/*
    KPLIB_fnc_logistics_calibrateTimer

    File: fn_logistics_calibrateTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 11:03:09
    Last Update: 2021-02-26 11:03:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calibrates a timer based on the '_transitPos', '_speedMps', and endpoint positions.

    Parameters:
        _alphaPos - ALPHA endpoint position [ARRAY, default: KPLIB_zeroPos]
        _bravoPos - BRAVO endpoint position [ARRAY, default: KPLIB_zeroPos]
        _transitPos - logistics telemetry transit position [ARRAY, default: KPLIB_zeroPos]
        _speedMps - a transport speed in meters per second (mps) [SCALAR, default: 0]

    Returns:
        A calibrated timer based on the given components [ARRAY, default: KPLIB_timers_default]
 */

params [
    ["_alphaPos", +KPLIB_zeroPos, [[]]]
    , ["_bravoPos", +KPLIB_zeroPos, [[]]]
    , ["_transitPos", +KPLIB_zeroPos, [[]]]
    , ["_speedMps", 0, [0]]
];

private _alphaBravoDistance = _alphaPos distance _bravoPos;

// If any of the key components are zero, respond with default, disabled timer
if (_alphaBravoDistance == 0 || _speedMps == 0) exitWith {
    // TODO: TBD: do some logging...
    +KPLIB_timers_default;
};

// '_duration' is the key component that changes when speed changes
private _duration = _alphaBravoDistance / _speedMps;

// As does '_elapsedTime', '_transitDistance' may be zero all day long, that is perfectly acceptable
private _elapsedTime = (_transitPos distance _alphaPos) / _speedMps;

// Then walk '_startTime' back from the server time given calculated elapsed time
private _startTime = serverTime - _elapsedTime;

// Similarly we can calibrate '_timeRemaining' as well
private _timeRemaining = _duration - _elapsedTime;

[
    _duration
    , _startTime
    , _elapsedTime
    , _timeRemaining
];
