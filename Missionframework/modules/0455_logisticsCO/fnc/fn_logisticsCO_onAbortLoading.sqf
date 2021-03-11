/*
    KPLIB_fnc_logisticsCO_onAbortLoading

    File: fn_logisticsCO_onAbortLoading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 16:35:53
    Last Update: 2021-03-06 16:35:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onAbortLoading_debug}
    ]
] call KLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

// Must do a role reversal...
([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_timer, []]
    , ["KPLIB_logistics_endpoints", []]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
    , "_endpoints"
    , "_convoy"
];

// TODO: TBD: because we may also need to inspect the request origin, either manager or automated...
// TODO: TBD: at the very least potentially also notify the user... perhaps broadcast that anyway...
([_changeOrder, [
    ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
];

// When there are zero loaded CONVOY TRANSPORTS at the moment of ABORT, then STANDBY
if (0 == ({ !(_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy)) then {

    _status = KPLIB_logistics_status_standby;
    _timer = +KPLIB_timers_default;
    _endpoints = [];

} else {

    // Otherwise, do a tactical ENDPOINT swap and re-set the timer, etc, and UNLOAD...
    _status = KPLIB_logistics_status_unloadingAborting;
    _timer = [KPLIB_param_logistics_transportLoadTimeSeconds] call KPLIB_fnc_timers_create;
    _endpoints = [_endpoints] call KPLIB_fnc_logistics_swapEndpoints;
};

[_namespace, [
    ["KPLIB_logistics_status", _status]
    , [KPLIB_logistics_timer, +_timer]
    , ["KPLIB_logistics_endpoints", +_endpoints]
]] call KPLIB_fnc_namespace_setVars;

true;
