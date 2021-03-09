/*
    KPLIB_fnc_logisticsSM_timerHasElapsed

    File: fn_logisticsSM_timerHasElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-04 18:27:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_namespace' timer has elapsed.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The array of CBA logistics namespaces [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_timer", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer call KPLIB_fnc_timers_hasElapsed;
