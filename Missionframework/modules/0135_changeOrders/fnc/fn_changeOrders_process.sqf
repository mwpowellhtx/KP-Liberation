/*
    KPLIB_fnc_changeOrders_process

    File: fn_changeOrders_process.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:50:25
    Last Update: 2021-03-06 09:50:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Processes the '_target' CHANGE ORDERS. Optionally receives a '_changeOrder'
        for immediate, priority processing.

    Parameters:
        _target - a target capable of supporting CHANGE ORDERS [LOCATION, default: locationNull]
        _changeOrder - an optional CHANGE ORDER, allows for immediate, priority processing
            [LOCATION, default: locationNull]

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
    , ["_changeOrder", locationNull, [locationNull]]
];

private _onProcess = {
    params ["_target", "_changeOrder"];
    ([_changeOrder, [
        ["KPLIB_changeOrder_onChangeOrder", { false; }]
        , ["KPLIB_changeOrder_onChangeOrderEntering", { false; }]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_onChangeOrder"
        , "_onChangeOrderEntering"
    ];

    if ([_target, _changeOrder] call _onChangeOrderEntering) then {
        [_target, _changeOrder] call _onChangeOrder;
    };

    [_changeOrder] call KPLIB_fnc_namespace_onGC;
};

// Allows for immediate processing of a single '_changeOrder'
if (!isNull _changeOrder) then {
    [_target, _changeOrder] call _onProcess;

    // Allowing for a signal whether to clear the CO queue
    ([_changeOrder, [
        ["KPLIB_logistics_clearQueueOnly", true]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_clearQueueOnly"
    ];

    // By default yes we clear the queue when having been given an immediate CO
    if (_clearQueueOnly) then {
        _onProcess = {
            params ["_target", "_changeOrder"];
            [_changeOrder] call KPLIB_fnc_namespace_onGC;
        };
    };
};

private _processing = true;

while {_processing} do {
    _changeOrder = [_target] call KPLIB_fnc_changeOrders_tryDequeue;
    _processing = !isNull _changeOrder;
    if (_processing) then { [_target, _changeOrder] call _onProcess; };
};

true;
