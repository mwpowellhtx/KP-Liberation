/*
    KPLIB_fnc_logisticsSM_tryUnloadNextTransport

    File: fn_logisticsSM_tryUnloadNextTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-05 01:12:09
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

// Make a genuine copy of the array
_convoy = +_convoy;

_endpoints params [
    ["_alpha", [], [[]], 4]
    , ["_bravo", [], [[]], 4]
];

_bravo params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];

private _transportValue = _convoy select _transportIndex;

if (!([_markerName, _transportValue] call KPLIB_fnc_logisticsSM_onApplyTransaction)) exitWith {
    false;
};

_convoy set [_transportIndex, +KPLIB_resources_storageValueDefault];

[_namespace, [
    [KPLIB_logistics_convoy, _convoy]
]] call KPLIB_fnc_namespace_setVars;

true;
