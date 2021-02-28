/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onUpdateReport

    File: fn_logisticsMgr_lnbTelemetry_onUpdateReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:57:10
    Last Update: 2021-02-28 09:57:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets the report which is used to coordinate with the Logistics Manager TELEMETRY LISTNBOX control.

    Parameters:
        _status - the logistics line status [SCALAR, default: -1]
        _timer - the logistics line timer [SCALAR, default: +KPLIB_timers_default]
        _transportSpeedKph - the transport speed in kilometers per hour (kph) [SCALAR, default: 0]

    Returns:
        A prepared TELEMETRY report given the incoming elements [ARRAY]

    References:
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/createHashMap
        https://community.bistudio.com/wiki/set
 */

params [
    ["_status", -1, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_transportSpeedKph", 0, [0]]
];

private _report = [] call KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport;

// TODO: TBD: there may be other bits...
private _statusReport = [_status] call KPLIB_fnc_logistics_getStatusReport;
private _durationReport = _timer + [{_this#0}] call KPLIB_fnc_timers_renderComponentString;
private _timeRemainingReport = _timer call KPLIB_fnc_timers_renderComponentString;
private _transportSpeedReport = toUpper (format ["%1 kph", (_transportSpeedKph toFixed 1)]);

{ _report set _x; } forEach [
    ["_status", _statusReport]
    , ["_duration", _durationReport]
    , ["_timeRemaining", _timeRemainingReport]
    , ["_transportSpeed", _transportSpeedReport]
];

_report;
