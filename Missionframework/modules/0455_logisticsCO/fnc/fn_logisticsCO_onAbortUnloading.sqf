/*
    KPLIB_fnc_logisticsCO_onAbortUnloading

    File: fn_logisticsCO_onAbortUnloading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 16:02:53
    Last Update: 2021-03-06 16:02:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Mission continues UNLOADING, then also ABORTING a well. May also be blocked
        due to NO_SPACE, but this is also fine and completely transparent to this
        operation.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onAbortUnloading_debug}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_timer, +KPLIB_timers_default]
    , [KPLIB_logistics_convoy, []]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
    , "_convoy"
    , "_endpoints"
];

_timer = +_timer;
_convoy = +_convoy;
_endpoints = +_endpoints;

// TODO: TBD: because we may also need to inspect the request origin, either manager or automated...
// TODO: TBD: at the very least potentially also notify the user... perhaps broadcast that anyway...
([_changeOrder, [
    ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
];

// When there are CONVOY TRANSPORTS remaining to UNLOAD, then allow CONTINUE MISSION...
if (0 < ({ !(_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy)) then {
    // May also be blocked for NO_SPACE, but is now also ABORTING...
    _status = [_status, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_setStatus;
} else {
    // ...or process the ABORT request IMMEDIATELY
    _status = KPLIB_logistics_status_standby;
    _timer = +KPLIB_timers_default;
    _endpoints = [];
};

[_namespace, [
    ["KPLIB_logistics_status", _status]
    , [KPLIB_logistics_timer, +_timer]
    , ["KPLIB_logistics_endpoints", +_endpoints]
]] call KPLIB_fnc_namespace_setVars;

// Success: ABORTED ... or ... ABORTING
[
    _status == KPLIB_logistics_status_standby
    , [_status, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
    , "_aborting"
];

_standby || _aborting;
