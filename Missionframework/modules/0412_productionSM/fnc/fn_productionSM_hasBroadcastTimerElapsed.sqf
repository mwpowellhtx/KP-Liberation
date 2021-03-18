/*
    KPLIB_fnc_productionSM_hasBroadcastTimerElapsed

    File: fn_productionSM_hasBroadcastTimerElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 19:21:24
    Last Update: 2021-03-17 19:21:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Obtains a default (running) BROADCAST TIMER, refreshes said timer, and evaluates
        whether has elapsed. Replaces the refreshed timer prior to returning. In effect,
        this is one fluid motion working with the timer. Automatically resets the timer
        when the timer has elapsed by default.

    Parameter(s):
        _reset - signals whether to reset the timer after evaluating for elapsed [BOOL, default: true]

    Returns:
        Whether the BROADCAST TIMER has elapsed [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_reset", true, [true]]
];

private _defaultTimer = [KPLIB_param_productionSM_broadcastPeriodSeconds] call KPLIB_fnc_timers_create;

([_objSM, [
    ["KPLIB_productionSM_broadcastTimer", _defaultTimer]
]] call KPLIB_fnc_namespace_getVars) params [
    "_broadcastTimer"
];

_broadcastTimer = _broadcastTimer call KPLIB_fnc_timers_refresh;

[
    _broadcastTimer call KPLIB_fnc_timers_hasElapsed
] params [
    "_elapsed"
];

if (_reset && _elapsed) then {
    _broadcastTimer = _defaultTimer;
};

[_objSM, [
    ["KPLIB_productionSM_broadcastTimer", _broadcastTimer]
]] call KPLIB_fnc_namespace_setVars;

_elapsed;
