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
        _config - the config

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
];

lnbClear _lnbTelemetry;

/* "Data" feeding TELEMETRY includes the LABEL and a HASHMAP KEY (i.e. string),
 * which we will use to coordinate updates with the LISTNBOX. */

private _data = [
    [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_STATUS_REPORT", "_status"]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_DURATION", "_duration"]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TIME_REMAINING", "_timeRemaining"]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TRANSPORT_SPEED", "_transportSpeed"]
];

{
    _x params [
        ["_label", "", [""]]
        , ["_reportHashMapKey", "", [""]]
    ];
    private _rowIndex = _lnbTelemetry lnbAddRow [_label, ""];
    _lnbTelemetry lnbSetData [[_rowIndex, 0], _reportHashMapKey];
} forEach _data;

true;