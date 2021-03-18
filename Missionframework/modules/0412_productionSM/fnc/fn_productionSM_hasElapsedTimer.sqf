/*
    KPLIB_fnc_productionSM_hasElapsedTimer

    File: fn_productionSM_hasElapsedTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 16:49:53
    Last Update: 2021-03-17 16:49:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA PRODUCTION namespace has an ELAPSED TIMER.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        Whether the CBA PRODUCTION namespace has an ELAPSED TIMER [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionSM_hasElapsedTimer_debug}
        , {_objSM getVariable ["KPLIB_param_productionSM_hasElapsedTimer_debug", false]}
        , {_namespace getVariable ["KPLIB_param_productionSM_hasElapsedTimer_debug", false]}
    ]
] call KPLIB_fnc_productionSM_debug;
 
([_namespace, [
    ["KPLIB_production_timer", +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer call KPLIB_fnc_timers_hasElapsed;
