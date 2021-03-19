/*
    KPLIB_fnc_productionSM_onStandbyOrPending

    File: fn_productionSM_onStandbyOrPending.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 16:54:17
    Last Update: 2021-03-17 16:54:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Processes all pending CHANGE ORDERS for the target CBA PRODUCTION namespace.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onPending", [""]]
];

private _debug = [
    [
        {KPLIB_param_productionSM_onStandbyOrPending_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onStandbyOrPending_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onStandbyOrPending_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    [KPLIB_changeOrders_orders, []]
    , ["KPLIB_production_markerName", ""]
    , ["KPLIB_production_baseMarkerText", ""]
]] call KPLIB_fnc_namespace_getVars) params [
    "_changeOrders"
    , "_markerName"
    , "_baseMarkerText"
];

private _changeOrderCount = count _changeOrders;

if (_debug && _changeOrderCount > 0) then {
    [format ["[fn_productionSM_onStandbyOrPending] Entering: [isNull _namespace, _callerName, _markerName, _baseMarkeText, _changeOrderCount]: %1"
        , str [isNull _namespace, _callerName, _markerName, _baseMarkerText, _changeOrderCount]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Process the CHANGE ORDERS first
[_namespace, _callerName] call KPLIB_fnc_changeOrders_process;

// Refresh the RUNNING TIMER after processing CHANGE ORDERS
[_namespace] call {

    params [
        ["_namespace", locationNull, [locationNull]]
    ];

    ([_namespace, [
        ["KPLIB_production_timer", +KPLIB_timers_default]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_timer"
    ];

    [_namespace, _callerName] call KPLIB_fnc_productionSM_onQualityControlQueue;

    if (_timer call KPLIB_fnc_timers_isRunning) then {
        [_namespace, [
            ["KPLIB_production_timer", (_timer call KPLIB_fnc_timers_refresh)]
        ]] call KPLIB_fnc_namespace_setVars;
    };
};

if (_debug && _changeOrderCount > 0) then {
    [format ["[fn_productionSM_onStandbyOrPending] Fini: [isNull _namespace, _callerName, _markerName, _baseMarkerText, _changeOrderCount]: %1"
        , str [isNull _namespace, _callerName, _markerName, _baseMarkerText, _changeOrderCount]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
