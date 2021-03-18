/*
    KPLIB_fnc_productionSM_onRebaseEntered

    File: fn_productionSM_onRebaseEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 16:28:21
    Last Update: 2021-03-17 16:28:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The first time the state machine sees each CBA PRODUCTION namespace, it must rebase
        the running production timers with a _startTime based on the currently running mission
        session. This is a recalibration of sorts, in order to maintain healthy mission
        continuance from the most recent saved state.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionSM_objSM;

private _debug = [
    [
        {KPLIB_param_productionSM_onRebaseEntered_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onRebaseEntered_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onRebaseEntered_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    , ["KPLIB_production_timer", +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_timer"
];

if (_debug) then {
    [format ["[fn_productionSM_onRebaseEntered] Entered: [_markerName, _timer]: %1"
        , str [_markerName, _timer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_timer = _timer call KPLIB_fnc_timers_rebase;

[_namespace, [
    ["KPLIB_production_timer", _timer]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_productionSM_onRebaseEntered] Fini: [_markerName, _timer]: %1"
        , str [_markerName, _timer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
