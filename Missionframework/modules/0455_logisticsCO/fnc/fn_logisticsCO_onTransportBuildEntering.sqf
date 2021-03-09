/*
    KPLIB_fnc_logisticsCO_onTransportBuildEntering

    File: fn_logisticsCO_onTransportBuildEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:12:55
    Last Update: 2021-03-06 09:12:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Entering logistics change order activity, this is the moment when that subsystem
        activity may be prohibited.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onTransportBuildEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

([_changeOrder, [
    ["KPLIB_logistics_targetUuid", ""]
    , ["KPLIB_logistics_targetFobMarker", ""]
    , ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_targetFobMarker"
    , "_cid"
];

// Only LOGISTIC LINES in certain STATUS may have CONVOY TRANSPORT build
(KPLIB_logisticsCO_status_transportRequestArray apply {
    [_status, _x] call KPLIB_fnc_logistics_checkStatus;
}) params [
    "_standby"
    , "_loadingUnloading"
];

if (!(_standby || _loadingUnloading)) exitWith {

    private _statusReport = [_status] call KPLIB_fnc_logistics_getStatusReport;

    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportBuildEntering] Status prohibits request: [_targetUuid, _targetFobMarker, '_statusReport', _status, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, ["'", "'"] joinString _statusReport, _status, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    [format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_CANNOT_BUILD", _statusReport]]
        remoteExec ["KPLIB_fnc_notification_hint", _cid];

    false;
};

if (_debug) then {
    ["[fn_logisticsCO_onTransportBuildEntering] Fini", "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
