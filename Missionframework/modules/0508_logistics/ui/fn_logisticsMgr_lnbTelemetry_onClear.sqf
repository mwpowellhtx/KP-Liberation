/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onClear

    File: fn_logisticsMgr_lnbTelemetry_onClear.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 11:06:38
    Last Update: 2021-03-01 17:01:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Prepares the TELEMETRY LISTNBOX for use throughout the Logistics Manager dialog session.

    Parameters:
        _lnbTelemetry - the logistics TELEMETRY LISTNBOX control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbTelemetry_onClear_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbTelemetry_onClear] Entering: [isNull _lnbTelemetry]: %1"
        , str [isNull _lnbTelemetry]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

lnbClear _lnbTelemetry;

/* "Data" feeding TELEMETRY includes the LABEL and a HASHMAP KEY (i.e. string),
 * which we will use to coordinate updates with the LISTNBOX. */

private _data = [
    [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_STATUS_REPORT", KPLIB_logistics_telemetry_hashMap_status]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_ESTIMATED_DISTANCE", KPLIB_logistics_telemetry_hashMap_estimatedDistance]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_ESTIMATED_DURATION", KPLIB_logistics_telemetry_hashMap_estimatedDuration]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_DURATION", KPLIB_logistics_telemetry_hashMap_duration]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_ELAPSED_TIME", KPLIB_logistics_telemetry_hashMap_elapsedTime]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TIME_REMAINING", KPLIB_logistics_telemetry_hashMap_timeRemaining]
    , [localize "STR_KPLIB_LOGISTICSMGR_LNBTELEMETRY_LBL_TRANSPORT_SPEED", KPLIB_logistics_telemetry_hashMap_transportSpeed]
];

private _onAddTelemetryRow = {
    _x params [
        ["_label", "", [""]]
        , ["_key", "", [""]]
    ];
    private _rowIndex = _lnbTelemetry lnbAddRow [_label, ""];
    _lnbTelemetry lnbSetData [[_rowIndex, 0], _key];
};

_onAddTelemetryRow forEach _data;

if (_debug) then {
    ["[fn_logisticsMgr_lnbTelemetry_onClear] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
