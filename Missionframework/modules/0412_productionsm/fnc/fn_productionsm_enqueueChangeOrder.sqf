/*
    KPLIB_fnc_productionsm_enqueueChangeOrder

    File: fn_productionsm_enqueueChangeOrder.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-02-19 13:50:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Raises the 'KPLIB_productionsm_onAddCapability' event with the CBA production statemachine.

    Parameter(s):
        _namespace - a CBA production '_namespace' [LOCATION, default: locationNull]
        _changeOrder - the requested '_changeOrder' [ARRAY, default: []]

    Returns:

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", [], [[]]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_enqueueChangeOrder] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if ([] isEqualTo _changeOrder) exitWith {
    if (_debug) then {
        ["[fn_productionsm_enqueueChangeOrder] No change orders", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Do a bit of validation on a decon'ed '_changeOrder' argument
_changeOrder params [
    ["_cid", -1, [0]]
    , ["_variableName", "", [""]]
    , "_pendingValue"
    , ["_onApplyChangeOrder", {}, [{}]]
];

private _changeOrders = _namespace getVariable ["_changeOrders", []];
_changeOrders pushBack _changeOrder;
_namespace setVariable ["_changeOrders", _changeOrders];

if (_debug) then {
    ["[fn_productionsm_enqueueChangeOrder] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
