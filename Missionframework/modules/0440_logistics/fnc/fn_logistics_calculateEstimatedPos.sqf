/*
    KPLIB_fnc_logistics_calculateEstimatedPos

    File: fn_logistics_calculateEstimatedPos.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 09:29:35
    Last Update: 2021-03-12 09:29:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates the estimated position of the running logistic line.

    Parameters:
        _namespace - a CBA logistics namespace []
        _target - a target reference object [OBJECT, default: objNull]
        _transportSpeedMps - the configured transport speed in meters per second
            [SCALAR, default: ([] call KPLIB_fnc_logistics_calculateTransportSpeedMps)]

    Returns:
        The estimated position of the logistic line [ARRAY]

    References:
        https://community.bistudio.com/wiki/getPos
 */

// TODO: TBD: might consider a variables fork: i.e. switch (...) ... { LOCATION | ARRAY | default }
params [
    ["_namespace", locationNull, [locationNull]]
    , ["_target", objNull, [objNull]]
    , ["_transportSpeedMps", ([] call KPLIB_fnc_logistics_calculateTransportSpeedMps), [0]]\
];

([_namespace, [
    [KPLIB_logistics_timer, +KPLIB_timers_default]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_timer", [], [[]]]
    , ["_endpoints", [], [[]]]
];

private _targetPos = if (isNull _target) then { +KPLIB_zeroPos; } else { getPos _target; };

if (_status <= KPLIB_logistics_status_standby) exitWith {
    // TODO: TBD: should log this...
    _targetPos;
};

_timer params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
];

_bravo params [
    ["_bravoPos", +KPLIB_zeroPos, [[]], 3]
];

[
    _alphaPos getDir _bravoPos
    , _elapsedTime * _transportSpeedMps
] params [
    "_direction"
    , "_distance"
];

// TODO: TBD: should log this...
private _estimatedPos = _alphaPos getPos [_distance, _direction];

_estimatedPos;
