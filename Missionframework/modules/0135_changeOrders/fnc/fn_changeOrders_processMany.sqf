/*
    KPLIB_fnc_changeOrders_processMany

    File: fn_changeOrders_processMany.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-14 15:28:57
    Last Update: 2021-03-14 15:29:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Processes CHANGE ORDERS based on a corresponding PREDICATE.

    Parameters:
        _target - a target capable of supporting CHANGE ORDERS [LOCATION, default: locationNull]
        _changeOrders - zero or more PREDICATED CONDITIONS [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_processMany_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
    , ["_changeOrders", [], [[]]]
    , ["_resetQueue", false, [false]]
    , ["_callerName", "fn_changeOrders_processMany", [""]]
];

private _count = 0;

private _selected = _changeOrders select {
    private _changeOrder = _x;

    ([_changeOrder, [
        [KPLIB_changeOrders_onChangeOrderEntering, { false; }]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_onChangeOrderEntering"
    ];

    [_target, _changeOrder] call _onChangeOrderEntering;
};

({
    private _changeOrder = _x;
    [_target, _x] call KPLIB_fnc_changeOrders_processOne;
} count _selected) > 0;
