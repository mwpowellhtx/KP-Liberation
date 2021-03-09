/*
    KPLIB_fnc_logistics_calculateLoadingStatus

    File: fn_logistics_calculateLoadingStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 21:13:25
    Last Update: 2021-03-07 21:29:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates a TRANSIT PLAN given the ALPHA+BRAVO ENDPOINTS, consisting
        of both STATUS and TIMER. Always from the perspective of either, continue
        LOADING the CONVOY TRANSPORTS, or transition to EN_ROUTE when fully loaded.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        TRANSIT PLAN consisting of: [STATUS, TIMER] [ARRAY]
 */

// TODO: TBD: sprinkle in debugging, entering, fini, reports...
private _debug = [
    [
        {KPLIB_param_logistics_calculateLoadingStatus_debug}
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
    [_namespace] call KPLIB_logistics_convoyIsFull
    , [_namespace] call KPLIB_fnc_logistics_alphaEndpointHasBillValue
    , [_status, KPLIB_logistics_status_noResource] call KPLIB_fnc_logistics_checkStatus
] params [
    "_full"
    , "_alphaHasBill"
    , "_noResource"
];

_status = switch (true) do {
    case (_alphaHasBill && _noResource && !_full): {
        KPLIB_logistics_status_loadingNoResource;
    };
    case (_alphaHasBill && !(_noResource || _full)): {
        KPLIB_logistics_status_loading;
    };
    default {
        KPLIB_logistics_status_enRoute;
    };
};

_status;
