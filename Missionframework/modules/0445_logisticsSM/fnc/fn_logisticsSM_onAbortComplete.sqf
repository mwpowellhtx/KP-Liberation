/*
    KPLIB_fnc_logisticsSM_onAbortComplete

    File: fn_logisticsSM_onAbortComplete.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 15:28:24
    Last Update: 2021-03-07 15:28:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Aborts the mission.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [ARRAY]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {KPLIB_param_logisticsSM_onAbortComplete_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

[_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_timer", +KPLIB_timers_default]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_setVars;

true;
