/*
    KPLIB_fnc_logisticsSM_checkStatus

    File: fn_logisticsSM_checkStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 23:11:19
    Last Update: 2021-03-05 23:11:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks the CBA logistics '_namespace' 'KPLIB_logistics_status' flag

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the '_namespace' status checked out okay [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_mask", KPLIB_logistics_status_standby, [0]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_status", KPLIB_logistics_status_standby, [0]]
];

[_status, _mask] call KPLIB_fnc_logistics_checkStatus;
