/*
    KPLIB_fnc_logistics_calculateUnloadingStatus

    File: fn_logistics_calculateUnloadingStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 11:51:06
    Last Update: 2021-03-08 05:58:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        ...
 */

// TODO: TBD: sprinkle in debugging, entering, fini, reports...
private _debug = [
    [
        {KPLIB_param_logistics_calculateArrivalPlan_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

[
    [_namespace] call KPLIB_fnc_logistics_convoyIsEmpty
    , [_namespace] call KPLIB_fnc_logistics_hasTransferCompleted
    , [_status, KPLIB_logistics_status_noSpace] call KPLIB_fnc_logistics_checkStatus
    , [_status, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
] params [
    "_empty"
    , "_completed"
    , "_noSpace"
    , "_aborting"
];

_status = switch (true) do {
    case (_aborting && !(_empty || _noSpace)): {
        KPLIB_logistics_status_unloading + KPLIB_logistics_status_aborting;
    };
    case (_aborting && (!_empty && _noSpace)): {
        KPLIB_logistics_status_unloadingNoSpace + KPLIB_logistics_status_aborting;
    };
    case (_empty && !(_completed || _aborting)): {
        KPLIB_logistics_status_loading;
    };
    case (!_empty && _noSpace): {
        KPLIB_logistics_status_unloadingNoSpace;
    };
    case (!(_empty || _noSpace)): {
        KPLIB_logistics_status_unloading;
    };
    default {
        KPLIB_logistics_status_standby;
    };
};

_status;
