/*
    KPLIB_fnc_logisticsSM_onRefreshTimer

    File: fn_logisticsSM_onRefreshTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 09:56:25
    Last Update: 2021-03-04 09:56:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Refreshes the CBA logistics namespace timer when the conditions permit doing
        so. The only state which prohibits refreshing the 'KPLIB_logistics_timer' is
        'KPLIB_logistics_status_routeBlocked'.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_timer", +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
];

if (!([_status, KPLIB_logistics_status_routeBlocked] call BIS_fnc_bitflagsCheck)) then {
    _timer = _timer call KPLIB_fnc_timers_refresh;
};

[_namespace, [
    ["KPLIB_logistics_timer", _timer]
]] call KPLIB_fnc_namespace_setVars;

true;
