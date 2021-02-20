/*
    KPLIB_fnc_productionsm_dequeueChangeOrder

    File: fn_productionsm_dequeueChangeOrder.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 18:13:24
    Last Update: 2021-02-19 18:13:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the next element in the '_changeOrders' queue, or '[]' when none were available.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The next element in the '_changeOrders' queue, or [] when none were available [ARRAY, default: []]
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_dequeueChangeOrder] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _changeOrders = _namespace getVariable ["_changeOrders", []];

private _changeOrder = [];

if (count _changeOrders > 0) then {
    _changeOrder = _changeOrders deleteAt 0;
    _namespace setVariable ["_changeOrders", _changeOrders];
};

if (_debug) then {
    ["[fn_productionsm_dequeueChangeOrder] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_changeOrder;
