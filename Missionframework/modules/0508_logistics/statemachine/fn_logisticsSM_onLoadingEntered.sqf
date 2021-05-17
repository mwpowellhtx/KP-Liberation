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

if (_debug) then {
    ["[fn_logisticsSM_onLoadingEntered] Entering...", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: it might even be better to respond with the actual resources tuple deficit... i.e. ({ _x < 0 } count _balance)
private _tried = [_namespace] call KPLIB_fnc_logisticsSM_tryLoadNextTransport;

if (_debug) then {
    [format ["[fn_logisticsSM_onLoadingEntered] Tried: [_tried]: %1"
        , str [_tried]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

[
    [_namespace] call KPLIB_fnc_logistics_convoyIsFull
] params [
    "_full"
];

// Set or unset cross-cutting flags depending on whether FULL, TRIED, etc
[_namespace, KPLIB_logistics_status_loading, { !_full; }] call KPLIB_fnc_logistics_setStatus;

[_namespace, KPLIB_logistics_status_noResource, { _tried; }] call KPLIB_fnc_logistics_unsetStatus;
[_namespace, KPLIB_logistics_status_noResource, { !(_full || _tried); }] call KPLIB_fnc_logistics_setStatus;

[_namespace, KPLIB_logistics_status_loading, { _full; }] call KPLIB_fnc_logistics_unsetStatus;
[_namespace, KPLIB_logistics_status_enRoute, { _full; }] call KPLIB_fnc_logistics_setStatus;

true;
