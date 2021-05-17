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
        Server side we only keep track of a few additional bits of detail over and above the
        core CBA logistics namespace elements.

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

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_endpoints", [], [[]]]
];

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

/* This is the server side equivalent to the client side Logistics Manager TELEMETRY LISTNBOX
 * view, for bits not otherwise identified by the parent LOGISTICS LINE tuple itself. This is
 * a map, from the server side CBA namespace variables, to Logistics Manager TELEMETRY LISTNBOX
 * and HASHMAP keys. */

private _telemetrySpecs = [
    ["KPLIB_logistics_telemetry_totalDistanceMeters", KPLIB_logistics_telemetry_totalDistance, (_alphaPos distance2D _bravoPos)]
    , ["KPLIB_logistics_telemetry_transitDistanceMeters", KPLIB_logistics_telemetry_transitDistance, 0]
    , ["KPLIB_logistics_telemetry_transportSpeed", KPLIB_logistics_telemetry_transportSpeed, (_transportSpeedMps/KPLIB_uom_kph_to_mps)]
    , ["KPLIB_logistics_telemetry_transitPos", KPLIB_logistics_telemetry_transitPos, +_alphaPos]
    , ["KPLIB_logistics_telemetry_transitDir", KPLIB_logistics_telemetry_transitDir, (_alphaPos getDir _bravoPos)]
    , ["KPLIB_logistics_telemetry_actualPos", KPLIB_logistics_telemetry_actualPos, +_alphaPos]
    , ["KPLIB_logistics_telemetry_actualDir", KPLIB_logistics_telemetry_actualDir, 0]
];

private _onGetAssociativeTelemetryArray = {
    _x params [
        ["_variableName", "", [""]]
        , ["_assocPairKey", "", [""]]
        , "_defaultValue"
    ];
    private _assocPairValue = _namespace getVariable [_variableName, _defaultValue];
    [_assocPairKey, _assocPairValue];
};

private _telemetry = (_telemetrySpecs apply _onGetAssociativeTelemetryArray);

_telemetry;
