/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport

    File: fn_logisticsMgr_lnbTelemetry_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 10:48:04
    Last Update: 2021-03-01 17:52:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the 'KPLIB_logisticsMgr_telemetryReport' TELEMETRY HASHMAP from the UI namespace.

    Parameters:
        _key - the UI namespace key corresponding to the TELEMETRY HASHMAP [STRING, default: 'KPLIB_logisticsMgr_telemetryReport']

    Returns:
        The TELEMETRY RPORT HASHMAP instance from the 'uiNamespace' [HASHMAP]

    References:
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/createHashMap
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_lnbTelemetry_getReport_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_key", "KPLIB_logisticsMgr_telemetryReport", [""]]
];

private _onGetHashMap = {
    uiNamespace getVariable _key;
};

if (isNil _onGetHashMap) then {
    uiNamespace setVariable [_key, createHashMap];
};

[] call _onGetHashMap;
