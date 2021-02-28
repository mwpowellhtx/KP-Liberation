/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport

    File: fn_logisticsMgr_lnbTelemetry_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 10:48:04
    Last Update: 2021-02-28 10:48:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the TELEMETRY REPORT HASHMAP from the 'uiNamespace'. May create one, if necessary.

    Parameters:
        NONE

    Returns:
        The TELEMETRY RPORT HASHMAP instance from the 'uiNamespace' [HASHMAP]

    References:
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/createHashMap
 */

private _key = "KPLIB_logisticsMgr_telemetryReport";

if (isNil { uiNamespace getVariable _key; }) then {
    uiNamespace setVariable [_key, createHashMap];
};

private _report = uiNamespace getVariable _key;

_report;
