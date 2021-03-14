/*
    KPLIB_fnc_logisticsSM_onPendingUnloading

    File: fn_logisticsSM_onPendingUnloading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 20:23:34
    Last Update: 2021-03-07 20:23:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onPendingUnloading_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

[
    [_namespace, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus
] params [
    "_unloading"
];

if (!_unloading) exitWith {
    false;
};

// Obliged to cycle through at least one UNLOADING phase...
private _timer = [KPLIB_param_logistics_transportLoadTimeSeconds] call KPLIB_fnc_timers_create;
[_namespace, [[KPLIB_logistics_timer, _timer]]] call KPLIB_fnc_namespace_setVars;
true;
