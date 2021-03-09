/*
    KPLIB_fnc_logisticsSM_onLoadingEntered

    File: fn_logisticsSM_onLoadingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-04 18:27:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_namespace' timer has elapsed.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The array of CBA logistics namespaces [ARRAY]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {KPLIB_param_logisticsSM_onLoadingEntered_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

private _transportIndex = [_namespace] call KPLIB_fnc_logistics_findNextTransportIndex;
// TODO: TBD: it might even be better to respond with the actual resources tuple deficit... i.e. ({ _x < 0 } count _balance)
private _tried = [_namespace, _transportIndex] call KPLIB_fnc_logisticsSM_tryLoadNextTransport;

_status = if (_tried) then {
    // NO_RESOURCE is cleared in part as a function calculating the TRANSIT PLAN...
    [_namespace] call KPLIB_fnc_logistics_calculateLoadingStatus;
} else {
    // Do not re-set any TIMER, allow it to continue running until NO_RESOURCE has cleared
    [_status, KPLIB_logistics_status_noResource] call KPLIB_fnc_logistics_setStatus;
};

// Continue mission LOADING, or transition to EN_ROUTE, as determined by the PLAN
[_namespace, [
    ["KPLIB_logistics_status", _status]
]] call KPLIB_fnc_namespace_setVars;

true;
