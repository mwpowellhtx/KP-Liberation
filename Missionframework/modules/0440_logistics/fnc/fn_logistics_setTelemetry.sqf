/*
    KPLIB_fnc_logistics_setTelemetry

    File: fn_logistics_setTelemetry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 13:57:43
    Last Update: 2021-02-26 13:57:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the '_namespace' telemetry variables given the '_telemetry' array.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _telemetry - a telemetry ARRAY to deconstruct and feed to the namespace [ARRAY, default: []]

    Returns:
        That the telemetry variables were set properly [BOOL]
 */

private _newSpeedMpsDefaultValue = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_telemetry", [], [[]]]
];

private _endpoints = _namespace getVariable ["KPLIB_logistics_endpoints", []];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

private _zeroPos = +KPLIB_zeroPos;

_alpha params [
    ["_alphaPos", _zeroPos, [[]]]
];

_bravo params [
    ["_bravoPos", _zeroPos, [[]]]
];

private _alphaBravoDistance = (_alphaPos distance2D _bravoPos);
private _defaultPos = +_alphaPos;
private _defaultDir = (_alphaPos getDir _bravoPos);

// Deconstruct the telemetry for purposes of injecting into the namespace variables
_telemetry params [
    ["_totalDistance", _alphaBravoDistance, [0]]
    , ["_transitDistance", 0, [0]]
    , ["_transportSpeed", (_newSpeedMpsDefaultValue / KPLIB_uom_kph_to_mps), [0]]
    , ["_transitPos", _defaultPos, [[]], 3]
    , ["_transitDir", _defaultDir, [0]]
    , ["_actualPos", _defaultPos, [[]], 3]
    , ["_actualDir", _defaultDir, [0]]
];

// Specify the TELEMETRY bits that we must refresh in the namespace...
private _telemetrySpecs = [
    ["KPLIB_logistics_telemetry_totalDistanceMeters", _totalDistance]
    , ["KPLIB_logistics_telemetry_transitDistanceMeters", _transitDistance]
    , ["KPLIB_logistics_telemetry_transportSpeed", _transportSpeed]
    , ["KPLIB_logistics_telemetry_transitPos", _transitPos]
    , ["KPLIB_logistics_telemetry_transitDir", _transitDir]
    , ["KPLIB_logistics_telemetry_actualPos", _actualPos]
    , ["KPLIB_logistics_telemetry_actualDir", _actualDir]
];

private _onSetTelemetryVariable = {
    private _variableName = (_x#0);
    private _value = (_x#1);
    _namespace setVariable [_variableName, _value];
    true;
};

private _result = (_telemetrySpecs select _onSetTelemetryVariable);

(count _result) == (count _telemetrySpecs);
