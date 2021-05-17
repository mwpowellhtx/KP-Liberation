/*
    KPLIB_fnc_logisticsSM_onUnloadingEntered

    File: fn_logisticsSM_onUnloadingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:37:17
    Last Update: 2021-03-05 18:00:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onUnloadingEntered_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {
    ["[fn_logisticsSM_onUnloadingEntered] Entering...", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

private _tried = [_namespace] call KPLIB_fnc_logisticsSM_tryUnloadNextTransport;

[
    [_namespace] call KPLIB_fnc_logistics_convoyIsEmpty
    , [_namespace] call KPLIB_fnc_logistics_hasTransferCompleted
    , [_namespace, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
] params [
    "_empty"
    , "_completed"
    , "_aborting"
];

[_namespace, KPLIB_logistics_status_noSpace, { !_tried; }] call KPLIB_fnc_logistics_setStatus;
[_namespace, KPLIB_logistics_status_noSpace, { _tried; }] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_unloading, { !_empty; }] call KPLIB_fnc_logistics_setStatus;
[_namespace, KPLIB_logistics_status_unloading, { _empty; }] call KPLIB_fnc_logistics_unsetStatus;

[_namespace, KPLIB_logistics_status_aborting, { _empty && (_aborting || _completed); }] call KPLIB_fnc_logistics_unsetStatus;
[_namespace, KPLIB_logistics_status_loading, { _empty && !(_aborting || _completed); }] call KPLIB_fnc_logistics_setStatus;

if (_debug) then {
    [format ["[fn_logisticsSM_onUnloadingEntered] Fini: [_tried, _empty, _completed]: %1"
        , str [_tried, _empty, _completed]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
