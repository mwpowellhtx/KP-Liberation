/*
    KPLIB_fnc_productionsm_hasChangeOrders

    File: fn_productionsm_hasChangeOrders.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-19 15:18:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether there are any '_changeOrders' remaining to be processed.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether there are any '_changeOrders' remaining [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_changeOrders_debug"
        , "KPLIB_param_productionsm_conditions_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_hasChangeOrders] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _changeOrders = _namespace getVariable ["_changeOrders", []];

if (_debug) then {
    [format ["[fn_productionsm_hasChangeOrders] Finished: [count _changeOrders]: %1"
        , str [count _changeOrders]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

count _changeOrders > 0;
