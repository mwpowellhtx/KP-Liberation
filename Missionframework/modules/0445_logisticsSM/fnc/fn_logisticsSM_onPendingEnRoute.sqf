/*
    KPLIB_fnc_logisticsSM_onPendingEnRoute

    File: fn_logisticsSM_onPendingEnRoute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 17:38:06
    Last Update: 2021-03-07 21:39:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

private _duration = [_endpoints] call KPLIB_fnc_logistics_calculateTransitDuration;

private _timer = [_duration] call KPLIB_fnc_timers_create;

[_namespace, [
    [KPLIB_logistics_timer, _timer]
]] call KPLIB_fnc_namespace_setVars;

true;
