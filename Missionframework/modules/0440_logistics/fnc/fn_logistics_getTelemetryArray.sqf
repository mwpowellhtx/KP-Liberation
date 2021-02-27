/*
    KPLIB_fnc_logistics_getTelemetryArray

    File: fn_logistics_getTelemetryArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 13:57:43
    Last Update: 2021-02-26 13:57:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a telemetry ARRAY corresponding to the _namespace element supporting the same.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _transportSpeedMps - the transport speed, in meters per second (mps) [SCALAR, default: _newSpeedMpsDefaultValue]

    Returns:
        A telemetry ARRAY corresponding to the same '_namespace' variables.
 */

private _speedMpsDefaultValue = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_transportSpeedMps", _speedMpsDefaultValue, [0]]
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

private _telemetrySpecs = [
    ["KPLIB_logistics_telemetry_totalDistanceMeters", (_alphaPos distance2D _bravoPos)]
    , ["KPLIB_logistics_telemetry_transitDistanceMeters", 0]
    , ["KPLIB_logistics_telemetry_transportSpeedMps", _transportSpeedMps]
    , ["KPLIB_logistics_telemetry_transitPos", +_alphaPos]
    , ["KPLIB_logistics_telemetry_transitDir", (_alphaPos getDir _bravoPos)]
    , ["KPLIB_logistics_telemetry_actualPos", +_alphaPos]
    , ["KPLIB_logistics_telemetry_actualDir", 0]
];

private _onGetTelemetrySpec = {
    _x params [
        ["_variableName", "", [""]]
        , "_defaultValue"
    ];
    private _value = _namespace getVariable [_variableName, _defaultValue];
    _value;
};

private _telemetry = (_telemetrySpecs apply _onGetTelemetrySpec);

_telemetry;
