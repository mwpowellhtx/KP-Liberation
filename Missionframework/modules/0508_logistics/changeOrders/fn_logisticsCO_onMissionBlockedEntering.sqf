/*
    KPLIB_fnc_logisticsCO_onMissionBlockedEntering

    File: fn_logisticsCO_onMissionBlockedEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 09:22:05
    Last Update: 2021-03-14 18:10:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Entering logistics change order activity, evaluates whether logistic
        can be considered blocked.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionBlockedEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

// Just exit early when the settings preclude this feature
if (!KPLIB_param_logistics_routesCanBeBlocked) exitWith {
    false;
};

([_changeOrder, [
    ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
];

// TODO: TBD: may not need CONVOY here after all...
([_namespace, [
    [KPLIB_logistics_timer, +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer params [
    "_duration"
    , "_startTime"
    , "_elapsedTime"
    , "_timeRemaining"
];

[
    [_namespace] call KPLIB_fnc_logistics_calculateEstimatedPos
    , KPLIB_sectors_all select { !(_x in KPLIB_sectors_blufor); }
] params [
    "_estimatedPos"
    , "_opforSectors"
];

[
    [] call KPLIB_fnc_logistics_calculateFobRangeSeconds
    , { ((markerPos _x) distance2D _estimatedPos) < KPLIB_param_sectors_capRange; } count _opforSectors
] params [
    "_fobRangeSeconds"
    , "_blockedByCount"
];

[
    _elapsedTime > _fobRangeSeconds
    , _timeRemaining <= _fobRangeSeconds
] params [
    "_departed"
    , "_arrived"
];

/* Perhaps a bit redundant, enRoute is of course departed, etc
 *      1. has departed, has not arrived
 *      2. considered en route
 *      3. neither ambushed nor already blocked
 *      4. at least one sector blocking
 */
[
    (_departed && !_arrived)
    , [_namespace, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_routeBlocked] call KPLIB_fnc_logistics_checkStatus
] params [
    "_timerEnRoute"
    , "_enRoute"
    , "_ambushed"
    , "_routeBlocked"
];

// Record some useful bits for the subsequent call back to utilize
[_changeOrder, [
    ["KPLIB_logistics_timerEnRoute", _timerEnRoute]
    , ["KPLIB_logistics_statusEnRoute", _enRoute]
    , ["KPLIB_logistics_statusAmbushed", _ambushed]
    , ["KPLIB_logistics_statusRouteBlocked", _routeBlocked]
    , ["KPLIB_logistics_blockedByCount", _blockedByCount]
]] call KPLIB_fnc_namespace_setVars;

// TODO: TBD: do some logging
// Either will be blocked, or route is now free and clear
_timerEnRoute && _enRoute && (
    (!(_ambushed || _routeBlocked) && _blockedByCount > 0)
        || ((_ambushed || _routeBlocked) && _blockedByCount == 0)
);
