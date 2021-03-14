/*
    KPLIB_fnc_changeOrders_process

    File: fn_changeOrders_process.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 21:07:43
    Last Update: 2021-03-13 21:07:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _target - a target capable of supporting CHANGE ORDERS [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_process_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
    , ["_callerName", "fn_changeOrders_process", [""]]
];

if (_debug) then {
    [format ["[fn_changeOrders_process] Entering: [isNull _target, _target, _callerName]: %1"
        , str [isNull _target, _target, _callerName]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: is it something about the namespace module causing an ACCESS_VIOLATION (?)
([_target, [
    [KPLIB_changeOrders_orders, []]
], _callerName] call KPLIB_fnc_namespace_getVars) params [
    "_changeOrders"
];
// private _changeOrders = _target getVariable [KPLIB_changeOrders_orders, []];

if (_debug) then {
    [format ["[fn_changeOrders_process] Got vars: [count _changeOrders]: %1"
        , str [count _changeOrders]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

// Nothing to do when there is nothing to do
if (_changeOrders isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_changeOrders_process] Nothing to process", "CHANGEORDERS", true] call KPLIB_fnc_common_log;
    };
    true;
};

// // TODO: TBD: for whatever reason, maybe this is the problem contributing to the ACCESS_VIOLATION...
// _changeOrders = +_changeOrders;
private _changeOrderSnapshot = _changeOrders select { true; };
private _changeOrderCount = count _changeOrderSnapshot;

if (_debug) then {
    [format ["[fn_changeOrders_process] Processing: [_callerName, _changeOrderCount]: %1"
        , str [_callerName, _changeOrderCount]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

{
    private _changeOrder = _x;
    private _changeOrderIndex = _forEachIndex;

    if (_debug) then {
        [format ["[fn_changeOrders_process] Processing: [_callerName, _changeOrderIndex, _changeOrderCount]: %1"
            , str [_callerName, _changeOrderIndex, _changeOrderCount]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
    };

    [_target, _changeOrder] call KPLIB_fnc_changeOrders_processOne;

} forEach _changeOrderSnapshot;

[_target, [
    [KPLIB_changeOrders_orders, []]
], false, _callerName] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    ["[fn_changeOrders_process] Fini", "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

true;
