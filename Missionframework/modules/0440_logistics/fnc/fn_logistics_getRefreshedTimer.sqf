/*
    KPLIB_fnc_logistics_getRefreshedTimer

    File: fn_logistics_getRefreshedTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 00:41:37
    Last Update: 2021-03-05 00:41:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        ... [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    [KPLIB_logistics_timer, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer = _timer call KPLIB_fnc_timers_refresh;

[_namespace, [
    [KPLIB_logistics_timer, _timer]
]] call KPLIB_fnc_namespace_setVars;

_timer;
