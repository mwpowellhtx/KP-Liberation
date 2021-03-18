/*
    KPLIB_fnc_productionSM_hasRunningTimer

    File: fn_productionSM_hasRunningTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 16:39:48
    Last Update: 2021-03-17 16:39:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA PRODUCTION namespace has a RUNNING TIMER.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        Whether the CBA PRODUCTION namespace has a RUNNING TIMER [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _debug = [
    [
        {KPLIB_param_productionSM_hasRunningTimer_debug}
    ]
] call KPLIB_fnc_productionSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_production_timer", +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer call KPLIB_fnc_timers_isRunning;
