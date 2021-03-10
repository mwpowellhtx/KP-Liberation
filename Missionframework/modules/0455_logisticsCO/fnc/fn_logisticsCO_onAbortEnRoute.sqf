/*
    KPLIB_fnc_logisticsCO_onAbortEnRoute

    File: fn_logisticsCO_onAbortEnRoute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 16:37:47
    Last Update: 2021-03-06 16:37:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Instructs the CBA logistics namespace to return to the nearest ENDPOINT,
        be it ALPHA or BRAVO, or to swap ENDPOINTS when the TRANSIT path was
        otherwise BLOCKED by enemy sectors. Critical that the timing is correct,
        because again, that IS the metric we utilize to gauge distance covered
        during transit, BRAVO ETA, etc.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onAbortEnRoute_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_timer, +KPLIB_timers_default]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
    , "_endpoints"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onAbortEnRoute] Entering: [_status, _timer, _endpoints]: %1"
        , str [_status, _timer, _endpoints]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_endpoints = +_endpoints;

// Just deconstruct the TIMER, which by this point we ought to have some confidence in
(+_timer) params ["_duration", "_startTime", "_elapsedTime", "_timeRemaining"];

private _abortedTimer = +_timer;

// Swap when not halfway, i.e. return shortest possible path, or...
if ((_elapsedTime < (_duration / 2)) || ([_status, KPLIB_logistics_status_routeBlocked] call KPLIB_fnc_logistics_checkStatus)) then {
//   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    // Re-orient the TIMER in the opposite direction, BRAVO becomes ALPHA, and vice versa
    _endpoints = [_endpoints] call KPLIB_fnc_logistics_swapEndpoints;

    // INVERT the TIMER, thereby reflecting the new swapped ENDPOINTS orientation
    _abortedTimer = _timer call KPLIB_fnc_timers_invert;

    if (_debug) then {
        [format ["[fn_logisticsCO_onAbortEnRoute] Endpoints swapped: [_timer, _abortedTimer, _endpoints]: %1"
            , str [_timer, _abortedTimer, _endpoints]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
};

_status = [_status, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_setStatus;

[_namespace, [
    ["KPLIB_logistics_status", _status]
    , [KPLIB_logistics_timer, _abortedTimer]
    , ["KPLIB_logistics_endpoints", +_endpoints]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsCO_onAbortEnRoute] Fini: [_status, _timer, _abortedTimer, _endpoints]: %1"
        , str [_status, _timer, _abortedTimer, _endpoints]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
