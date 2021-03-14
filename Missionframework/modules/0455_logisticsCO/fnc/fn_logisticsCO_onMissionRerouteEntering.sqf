/*
    KPLIB_fnc_logisticsCO_onMissionRerouteEntering

    File: fn_logisticsCO_onMissionRerouteEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:01:18
    Last Update: 2021-03-13 13:01:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionRerouteEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_endpoints"
];

[
    [_status, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_checkStatus
] params [
    "_abandoned"
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

_alpha params [
    ["_0", +KPLIB_zeroPos, [[]], 3]
    , ["_alphaMarker", "", [""]]
];

// '_4' leaving room for ALPHA bits
_bravo params [
    ["_4", +KPLIB_zeroPos, [[]], 3]
    , ["_bravoMarker", "", [""]]
];

private _allEndpoints = [] call KPLIB_fnc_logistics_getEndpoints;
private _bluforSectors = +KPLIB_sectors_blufor;

[
    _allEndpoints findIf { [_x, _alpha] call KPLIB_fnc_logistics_areEndpointsEqual; }
    , _allEndpoints findIf { [_x, _bravo] call KPLIB_fnc_logistics_areEndpointsEqual; }
    , _alphaMarker in _bluforSectors
    , _bravoMarker in _bluforSectors
] params [
    "_alphaIsEndpoint"
    , "_bravoIsEndpoint"
    , "_alphaIsFactory"
    , "_bravoIsFactory"
];

// TODO: TBD: might be a CBA setting, re: whether "lost FOB" considered strong enough to warrant ABANDONED change order?
if (!_abandoned || (_alphaIsEndpoint && _bravoIsEndpoint)) exitWith {
    false;
};

// When either ALPHA or BRAVO are no longer an available ENDPOINT, then we must reconsider
[_changeOrder, [
    ["KPLIB_logistics_status", _status]
    , ["KPLIB_logistics_alphaEndpoint", +_alpha]
    , ["KPLIB_logistics_bravoEndpoint", +_bravo]
    , ["KPLIB_logistics_allEndpoints", +_allEndpoints]
    , ["KPLIB_logistics_bluforSectors", +_bluforSectors]
    , ["KPLIB_logistics_alphaIsEndpoint", _alphaIsEndpoint]
    , ["KPLIB_logistics_bravoIsEndpoint", _bravoIsEndpoint]
    , ["KPLIB_logistics_alphaIsFactory", _alphaIsFactory]
    , ["KPLIB_logistics_bravoIsFactory", _bravoIsFactory]
]] call KPLIB_fnc_namespace_setVars;

true;
