/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport

    File: fn_logisticsMgr_lnbTelemetry_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 10:48:04
    Last Update: 2021-03-01 10:40:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the TELEMETRY REPORT HASHMAP from the 'uiNamespace'. May create one, if necessary.

    Parameters:
        _zero - whether to zero the key strategic bits of the report [BOOL, default: false]
        _reports - the bits that inform the TELEMETRY reports [ARRAY, default: []]

    Returns:
        The TELEMETRY RPORT HASHMAP instance from the 'uiNamespace' [HASHMAP]

    Remarks:
        NONE

    References:
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/createHashMap
 */

params [
    ["_zero", false, [false]]
    , ["_reports", [], [[]]]
];

_reports params [
    ["_status", KPLIB_logistics_status_na, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_transportSpeedKph", KPLIB_param_logistics_transportSpeedKph, [0]]
];

if (_zero) then {
    _status = KPLIB_logistics_status_na;
    _timer = +KPLIB_timers_default;
    _transportSpeedKph = 0;
};

private _key = "KPLIB_logisticsMgr_telemetryReport";

if (isNil { uiNamespace getVariable _key; }) then {
    uiNamespace setVariable [_key, createHashMap];
};

private _report = uiNamespace getVariable _key;

private _onSetReport = {
    _x params [
        ["_key", "", [""]]
        , ["_text", "", [""]]
    ];
    _report set [_key, _text];
};

// TODO: TBD: append any new or interesting telemetry bits here...
_onSetReport forEach [
    [KPLIB_logistics_telemetry_hashMap_status, [_status] call KPLIB_fnc_logistics_getStatusReport]
    , [KPLIB_logistics_telemetry_hashMap_duration, (_timer + [{ (_this#0); }]) call KPLIB_fnc_timers_renderComponentString]
    , [KPLIB_logistics_telemetry_hashMap_elapsedTime, (_timer + [{ (_this#2); }]) call KPLIB_fnc_timers_renderComponentString]
    , [KPLIB_logistics_telemetry_hashMap_timeRemaining, _timer call KPLIB_fnc_timers_renderComponentString]
    , [KPLIB_logistics_telemetry_hashMap_transportSpeed, (_transportSpeedKph toFixed 1)]
];

private _telemetry = uiNamespace getVariable ["KPLIB_logisticsMgr_telemetry", []];

_report;
