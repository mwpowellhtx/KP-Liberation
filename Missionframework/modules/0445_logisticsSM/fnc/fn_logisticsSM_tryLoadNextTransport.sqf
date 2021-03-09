/*
    KPLIB_fnc_logisticsSM_tryLoadNextTransport

    File: fn_logisticsSM_tryLoadNextTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-05 00:01:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_namespace' timer has elapsed.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _transportIndex - [SCALAR, default: -1]

    Returns:
        The array of CBA logistics namespaces [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_transportIndex", -1, [0]]
];

if (isNull _namespace || _transportIndex < 0) exitWith {
    false;
};

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_timer", []]
    , ["KPLIB_logistics_endpoints", []]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
    , "_endpoints"
    , "_convoy"
];

// So that we are indeed working with a genuine copy
_convoy = +_convoy;

_endpoints params [
    ["_alpha", [], [[]], 4]
];

_alpha params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
    , ["_billValue", [], [[]], 3]
];

private _loadVolumes = [_billValue] call KPLIB_fnc_logisticsSM_getLoadVolumes;

if (!([_markerName, _loadVolumes, KPLIB_fnc_resources_pay] call KPLIB_fnc_logisticsSM_onApplyTransaction)) exitWith {
    false;
};

_convoy set [_transportIndex, _loadValue];

// Bill value less load value, in LINQ zip manner...
private _remainingValue = [_billValue, _loadValue, {(_this#0) - (_this#1)}] call KPLIB_fnc_linq_zip;
// TODO: TBD: probably unnecessary to set so much here...
_endpoints set [0, +[_pos, _markerName, _baseMarkerText, _remainingValue]];

[_namespace, [
    [KPLIB_logistics_convoy, +_convoy]
    , ["KPLIB_logistics_endpoints", +_endpoints]
]] call KPLIB_fnc_namespace_setVars;

true;
