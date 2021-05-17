/*
    KPLIB_fnc_logisticsCO_onAbortUnloading

    File: fn_logisticsCO_onAbortUnloading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 16:02:53
    Last Update: 2021-03-14 18:11:17
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

[
    [_namespace] call KPLIB_fnc_logistics_convoyIsEmpty
] params [
    "_empty"
];

[_namespace, KPLIB_logistics_status_aborting, { !_empty }] call KPLIB_fnc_logistics_setStatus;
[_namespace, KPLIB_logistics_status_aborting, { _empty }] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_unloading, { _empty }] call KPLIB_fnc_logistics_unsetStatus;

[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
];

if (_standby) then {
    [_namespace, [
        [KPLIB_logistics_timer, +KPLIB_timers_default]
        , ["KPLIB_logistics_endpoints", []]
    ]] call KPLIB_fnc_namespace_setVars;
};

true;
