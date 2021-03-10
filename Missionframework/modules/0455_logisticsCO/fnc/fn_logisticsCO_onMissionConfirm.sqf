/*
    KPLIB_fnc_logisticsCO_onMissionConfirm

    File: fn_logisticsCO_onMissionConfirm.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 12:22:34
    Last Update: 2021-03-06 12:22:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Plans a new LOGISTIC MISSION given the ENDPOINTS and so forth. May occur in
        response to the LOGISTIC MANAGER having submitted the requested change order.
        May also occur with every new LOGISTIC TRANSIT leg, when ALPHA+BRAVO are swapped
        and the next leg is scheduled.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The change order finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionConfirm_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_changeOrder, [
    ["KPLIB_logistics_endpoints", []]
    , ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
    , "_cid"
];

private _status = [_namespace] call KPLIB_fnc_logistics_calculateMissionStatus;
private _loading = [_status, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_checkStatus;

private _timer = if (!_loading) then {
    +KPLIB_timers_default;
} else {
    [KPLIB_param_logistics_transportLoadTimeSeconds] call KPLIB_fnc_timers_create;
};

[_namespace, [
    ["KPLIB_logistics_status", _status]
    , [KPLIB_logistics_timer, _timer]
    , ["KPLIB_logistics_endpoints", _endpoints]
]] call KPLIB_fnc_namespace_setVars;

if (_cid >= 0) then {
    [
        localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CONFIRMED"
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
};

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionConfirm] Fini: [_loading, _status, _timer, _endpoints]: %1"
        , str [_loading, _status, _timer, _endpoints]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

if (_cid < 0) then {
    [_changeOrder] call KPLIB_fnc_namespace_onGC;
};

true;
