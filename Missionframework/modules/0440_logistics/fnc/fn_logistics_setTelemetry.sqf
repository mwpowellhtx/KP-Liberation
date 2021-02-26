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

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]]]
];

_bravo params [
    ["_bravoPos", +KPLIB_zeroPos, [[]]]
];

private _alphaBravoDistance = _alphaPos distance2D _bravoPos;
private _alphaBravoDir = _alphaPos getDir _bravoPos;

// Deconstruct the telemetry for purposes of injecting into the namespace variables
_telemetry params [
    ["_totalDistanceMeters", _alphaBravoDistance, [0]]
    , ["_transitDistanceMeters", 0, [0]]
    , ["_transportSpeedMps", _newSpeedMpsDefaultValue, [0]]
    , ["_transitPos", +_alphaPos, [[]]]
    , ["_transitDir", _alphaBravoDir, [0]]
    , ["_actualPos", +_alphaPos, [[]]]
    , ["_actualDir", _alphaBravoDir, [0]]
];

private _telemetrySpecs = [
    ["KPLIB_logistics_telemetry_totalDistanceMeters", _totalDistanceMeters]
    , ["KPLIB_logistics_telemetry_transitDistanceMeters", _transitDistanceMeters]
    , ["KPLIB_logistics_telemetry_transportSpeedMps", _transportSpeedMps]
    , ["KPLIB_logistics_telemetry_transitPos", _transitPos]
    , ["KPLIB_logistics_telemetry_transitDir", _transitDir]
    , ["KPLIB_logistics_telemetry_actualPos", _actualPos]
    , ["KPLIB_logistics_telemetry_actualDir", _actualDir]
];

private _onSetTelemetryVariable = {
    _x params [
        ["_variableName", "", [""]]
        , "_value"
    ];
    _namespace setVariable [_variableName, _value];
    true;
};

private _result = (_telemetrySpecs select _onSetTelemetryVariable);

(count _result) == (count _telemetrySpecs);
