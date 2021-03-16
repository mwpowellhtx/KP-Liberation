/*
    KPLIB_fnc_logisticsCO_onMissionRerouteEntering

    File: fn_logisticsCO_onMissionRerouteEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-15 14:01:50
    Last Update: 2021-03-15 14:01:54
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
        {KPLIB_param_logisticsCO_onMissionRerouteEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionRerouteEntering] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_lineEps"
];

// Elaborate the bits that are required when entering the CHANGE ORDER
[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_checkStatus
    , [_namespace] call KPLIB_fnc_logistics_getEndpointIndexes
    , [] call KPLIB_fnc_logistics_getEndpoints
] params [
    "_standby"
    , "_statusAmbushed"
    , "_statusAbandoned"
    , "_lineEpIndexes"
    , "_canEps"
];

// Go ahead and relay the CHANGE ORDER elements.
[_changeOrder, [
    ["KPLIB_logistics_lineEndpoints", _lineEps]
    , ["KPLIB_logistics_candidateEndpoints", _canEps]
    , ["KPLIB_logistics_lineEndpointIndexes", _lineEpIndexes]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionRerouteEntering] Fini: [_standby, _statusAmbushed, _statusAbandoned, _lineEpIndexes]: %1"
        , str [_standby, _statusAmbushed, _statusAbandoned, _lineEpIndexes]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

!(_standby || _statusAmbushed)
    && _statusAbandoned
    && ({ (_x < 0); } count _lineEpIndexes) > 0;
