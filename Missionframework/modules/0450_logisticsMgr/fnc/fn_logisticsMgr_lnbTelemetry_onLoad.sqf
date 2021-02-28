/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoad

    File: fn_logisticsMgr_lnbTelemetry_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 11:06:38
    Last Update: 2021-02-28 11:06:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Prepares the TELEMETRY LISTNBOX for use throughout the Logistics Manager dialog session.

    Parameters:
        _lnbTelemetry - the logistics telemetry LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbTelemetry", _lnbTelemetry];

[_lnbTelemetry] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onClear;

true;
