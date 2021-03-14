/*
    KPLIB_fnc_changeOrders_processOne

    File: fn_changeOrders_processOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 21:04:27
    Last Update: 2021-03-13 21:04:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Processes one single CHANGE ORDER given the TARGET object.

    Parameters:
        _target - a target capable of supporting CHANGE ORDERS [LOCATION, default: locationNull]
        _changeOrder - one single CHANGE ORDER for immediate processing [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_processOne_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
    , ["_resetQueue", false, [false]]
    , ["_callerName", "fn_changeOrders_processOne", [""]]
];

([_changeOrder, [
    [KPLIB_changeOrders_onChangeOrder, { false; }]
    , [KPLIB_changeOrders_onChangeOrderEntering, { false; }]
], _callerName] call KPLIB_fnc_namespace_getVars) params [
    "_onChangeOrder"
    , "_onChangeOrderEntered"
];

private _processed = false;
private _entered = [_target, _changeOrder] call _onChangeOrderEntered;

if (_entered) then {
    [_target, _changeOrder] call _onChangeOrder;
    _processed = true;
};

if (_resetQueue) then {
    [_target, [
        [KPLIB_changeOrders_orders, []]
    ], false, _callerName] call KPLIB_fnc_namespace_setVars;
};

[_changeOrder] call CBA_fnc_namespace_onGC;

_entered && _processed;
