/*
    KPLIB_fnc_productionsm_hasProductionTimer

    File: fn_productionsm_hasProductionTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 15:42:14
    Last Update: 2021-02-17 15:42:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production '_namespace' timer has met the '_timerPredicate' condition.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _timerPredicate - a timer predicate, should return BOOL [CODE, default: KPLIB_fnc_timers_hasElapsed]

    Returns:
        Whether the '_namespace' has met the '_timerPredicate' condition [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_timerPredicate", KPLIB_fnc_timers_hasElapsed, [{}]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_conditions_debug"
        , "KPLIB_param_productionsm_producer_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_conditions_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_producer_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

if (_debug) then {
    [format ["[fn_productionsm_hasProductionTimer] Entering: [_markerName, _baseMarkerText]: %1"
        , str [_markerName, _baseMarkerText]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _timer = _namespace getVariable ["_timer", KPLIB_timers_default];
private _retval = _timer call _timerPredicate;

if (_debug) then {
    [format ["[fn_productionsm_hasProductionTimer] Fini: [_markerName, _baseMarkerText, _timer, _retval]: %1"
        , str [_markerName, _baseMarkerText, _timer, _retval]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_retval;
