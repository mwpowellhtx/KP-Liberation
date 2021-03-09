/*
    KPLIB_fnc_logisticsMgr_onCalculateEstimatedDuration

    File: fn_logisticsMgr_onCalculateEstimatedDuration.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 23:10:31
    Last Update: 2021-03-01 23:10:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Recalculates the estimated duration between

    Parameters:
        _transportSpeedMps - ...

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbCurSelRow
 */

params [
    ["_transportSpeedMps", [] call KPLIB_fnc_logistics_calculateTransportSpeedMps, [0]]
];

private _line = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_line params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_na, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
];

uiNamespace setVariable ["KPLIB_logisitcsMgr_estimatedDistance", nil];
uiNamespace setVariable ["KPLIB_logisitcsMgr_estimatedDuration", nil];

// When lines are in motion and doing something, then there are no more "estimates"
if (_status > KPLIB_logistics_status_standby) exitWith {
    // TODO: TBD: and maybe some logging...
    true;
};

private _variableNames = [
    "KPLIB_logisticsMgr_cboAlpha"
    , "KPLIB_logisticsMgr_cboBravo"
];

private _onGetEndpointCtrl = {
    uiNamespace getVariable [_x, controlNull];
};

private _onGetEndpointMarker = {
    [_x] call KPLIB_fnc_logisticsMgr_cboEndpoint_getSelectedEndpoint;
};

// We could also extract the marker and marker pos, but this is great also...
private _onGetMarkerPos = {
    _x params [
        ["_endpointPos", +KPLIB_zeroPos, [[]], 3]
    ];
    _endpointPos;
};

// TODO: TBD: this really really REALLY needs to be refactored...
private _endpointPositions = _variableNames
    apply _onGetEndpointCtrl
    apply _onGetEndpointMarker
    apply _onGetMarkerPos;

_endpointPositions params [
    ["_alphaPos", [], [[]], 3]
    , ["_bravoPos", [], [[]], 3]
];

// TODO: TBD: should only recalculate when the line is not committed, i.e. is in STANDBY...
private _estimatedDistance = _alphaPos distance2D _bravoPos;
private _estimatedDuration = _estimatedDistance / _transportSpeedMps;

uiNamespace setVariable ["KPLIB_logisitcsMgr_estimatedDistance", _estimatedDistance];
uiNamespace setVariable ["KPLIB_logisitcsMgr_estimatedDuration", _estimatedDuration];

[false, [_status, _timer]] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onUpdateReport;

[] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onRefresh;

true;
