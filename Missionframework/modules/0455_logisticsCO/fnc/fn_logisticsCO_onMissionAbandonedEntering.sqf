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

// First identify basic building blocks
[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_checkStatus
    // This is the key right here, "so much" it bound up in this one request, but it really is that simple
    , [_namespace] call KPLIB_fnc_logistics_areEndpointsAbandoned
] params [
    "_standby"
    , "_statusAmbushed"
    , "_statusAbandoned"
    , "_areEpsAbandoned"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandonedEntering] Fini: [_standby, _statusAmbushed, _statusAbandoned, _areEpsAbandoned]: %1"
        , str [_standby, _statusAmbushed, _statusAbandoned, _areEpsAbandoned]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

!(
    _standby
        || _statusAmbushed
        || _statusAbandoned
) && _areEpsAbandoned;
