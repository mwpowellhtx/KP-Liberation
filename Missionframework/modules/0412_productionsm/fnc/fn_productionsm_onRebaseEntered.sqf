/*
    KPLIB_fnc_productionsm_onRebaseEntered

    File: fn_productionsm_onRebaseEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 14:57:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The first time the statemachine sees each '_namespace', it must rebase any running
        '_timer' with a _startTime based on the currently running mission session. This is
        a recalibration of sorts, in order to maintain healthy mission continuance from the
        most recent saved state.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        NONE
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionsm_objSM;

private _debug = [
    [
        "KPLIB_param_productionsm_rebaserEntered_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_rebaserEntered_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_rebaserEntered_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _timer = _namespace getVariable ["_timer", KPLIB_timers_default];

if (_debug) then {
    [format ["[fn_productionsm_onRebaseEntered] Entered: [_markerName, _timer]: %1"
        , str [_markerName, _timer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (_timer call KPLIB_fnc_timers_isRunning) then {
    _namespace setVariable ["_timer", (_timer call KPLIB_fnc_timers_rebase)];
};

if (_debug) then {
    [format ["[fn_productionsm_onRebaseEntered] Finished: [_markerName, _timer]: %1"
        , str [_markerName, _timer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
