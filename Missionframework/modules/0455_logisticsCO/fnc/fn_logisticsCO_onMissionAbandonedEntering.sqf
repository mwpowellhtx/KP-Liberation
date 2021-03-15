/*
    KPLIB_fnc_logisticsCO_onMissionAbandonedEntering

    File: fn_logisticsCO_onMissionAbandonedEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:01:18
    Last Update: 2021-03-15 01:18:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Screens for the periodic determination whether line is considered ABANDONED.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionAbandonedEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Evaluating: [_endpoints apply { (_x#1); }]: %1"
        , str [_endpoints apply { (_x#1); }]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
    , "_ambushed"
    , "_abandoned"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Evaluating: [_standby, _abandoned, _ambushed]: %1"
        , str [_standby, _abandoned, _ambushed]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// On STANDBY or already ABANDONED, nothing further to decide
if (_standby || _abandoned || _abandoned) exitWith {
    // TODO: TBD: may add logging...
    false;
};

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Evaluating: [[_alpha, _bravo] apply { (_x#1); }]: %1"
        , str [[_alpha, _bravo] apply { (_x#1); }]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: we may also ask for BLUFOR sectors, but this is rolled up by the function
private _allEndpoints = [] call KPLIB_fnc_logistics_getEndpoints;
private _bluforSectors = +KPLIB_sectors_blufor;

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Evaluating: [count _allEndpoints]: %1"
        , str [count _allEndpoints]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

[
    _allEndpoints findIf { [_x, _alpha] call KPLIB_fnc_logistics_areEndpointsEqual; }
    , _allEndpoints findIf { [_x, _bravo] call KPLIB_fnc_logistics_areEndpointsEqual; }
    , _alphaMarker in _bluforSectors
    , _bravoMarker in _bluforSectors
] params [
    "_alphaIndex"
    , "_bravoIndex"
    , "_alphaIsFactory"
    , "_bravoIsFactory"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Evaluating: [_alphaIndex, _bravoIndex]: %1"
        , str [_alphaIndex, _bravoIndex]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// ABANDONED when either or both ENDPOINT is "not" an endpoint
private _verifiedIndexes = [_alphaIndex, _bravoIndex] select { (_x >= 0); };

[_changeOrder, [
    ["KPLIB_logistics_endpoints", [_alpha, _bravo]]
    , ["KPLIB_logistics_endpointIndexes", [_alphaIndex, _bravoIndex]]
    , ["KPLIB_logistics_endpointsAreFactories", [_alphaIsFactory, _bravoIsFactory]]
    , ["KPLIB_logistics_statusStandby", _standby]
    , ["KPLIB_logistics_statusAmbushed", _ambushed]
    , ["KPLIB_logistics_statusAbandoned", _abandoned]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Fini: [_verifiedIndexes]: %1"
        , str [_verifiedIndexes]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

count _verifiedIndexes != count [_alpha, _bravo];
