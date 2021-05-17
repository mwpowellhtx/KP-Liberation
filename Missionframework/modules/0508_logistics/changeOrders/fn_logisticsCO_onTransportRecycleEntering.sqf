/*
    KPLIB_fnc_logisticsCO_onTransportRecycleEntering

    File: fn_logisticsCO_onTransportRecycleEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 12:06:32
    Last Update: 2021-03-01 15:07:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Entering logistics change order activity, this is the moment when that subsystem
        activity may be prohibited. Verifies a couple of leading prohibitions, stopping
        just short of actually evaluating any credits, economics, etc.

    Parameters:
        _namespace - a CBA logistics namespace for which the change order is happening [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onTransportRecycleEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_convoy"
];

([_changeOrder, [
    ["KPLIB_logistics_targetUuid", ""]
    , ["KPLIB_logistics_targetFobMarker", []]
    , ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_targetFobMarker"
    , "_cid"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onTransportRecycleEntering] Entering: [_targetUuid, _targetFobMarker, _cid]: %1"
        , str [_targetUuid, _targetFobMarker, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportRecycleEntering] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    false;
};

// And verify that the STATUS allows for a CONVOY TRANSPORT to be RECYCLED...
(KPLIB_logisticsCO_status_transportRequestArray apply {
    [_status, _x] call KPLIB_fnc_logistics_checkStatus;
}) params ["_standby", "_loadingUnloading"];

if (!(_standby || _loadingUnloading)) exitWith {

    private _statusReport = [_status] call KPLIB_fnc_logistics_getStatusReport;

    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportRecycleEntering] Status prohibits request or convoys are all occupied: [_targetUuid, _targetFobMarker, _convoyIndex, '_statusReport', _status, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _convoyIndex, ["'", "'"] joinString _statusReport, _status, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    [
        format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_CANNOT_RECYCLE", _statusReport]
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    false;
};

// Verify that there is a CONVOY TRANSPORT available to be RECYCLED...
if (({ (_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy) == 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportRecycleEntering] Convoy transport cannot be recycled: [_targetUuid, _targetFobMarker, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: not so much "empty" as "transports cannot be recycled OR empty" ...
    [
        localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_RECYCLE_EMPTY"
        , 7
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    false;
};

if (_debug) then {
    ["[fn_logisticsCO_onTransportRecycleEntering] Fini", "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
