/*
    KPLIB_fnc_logisticsCO_onMissionBlocked

    File: fn_logisticsCO_onMissionBlocked.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 10:14:26
    Last Update: 2021-03-14 18:10:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Entering logistics change order activity, closes the loop on a BLOCKED mission.
        There is some overlap here with an AMBUSHED mission, but only a little.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionBlocked_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_changeOrder, [
    ["KPLIB_logistics_timerEnRoute", false]
    , ["KPLIB_logistics_statusEnRoute", false]
    , ["KPLIB_logistics_statusAmbushed", false]
    , ["KPLIB_logistics_statusRouteBlocked", false]
    , ["KPLIB_logistics_blockedByCount", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timerEnRoute"
    , "_enRoute"
    , "_ambushed"
    , "_routeBlocked"
    , "_blockedByCount"
];

// TODO: TBD: add logging...

[_namespace, KPLIB_logistics_status_routeBlocked, { !(_timerEnRoute || _enRoute); }] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_routeBlocked
    , { _timerEnRoute && _enRoute && (!(_ambushed || _routeBlocked) && _blockedByCount > 0); }] call KPLIB_fnc_logistics_setStatus;

[_namespace, KPLIB_logistics_status_routeBlocked
    , { _timerEnRoute && _enRoute && ((_ambushed || _routeBlocked) && _blockedByCount == 0); }] call KPLIB_fnc_logistics_unsetStatus;

true;
