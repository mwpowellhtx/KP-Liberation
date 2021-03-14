/*
    KPLIB_fnc_changeOrders_insert

    File: fn_changeOrders_insert.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 10:22:22
    Last Update: 2021-03-12 10:22:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Inserts a '_target' oriented CHANGE ORDER(s).

    Parameters:
        _target - an object for which to perform the CO [OBJECT, default: objNull]
        _changeOrders - a CBA change order namespace or namespaces [LOCATION|ARRAY, default: locationNull]
        _index - the index to use inserting change orders [SCALAR, default: 0]

    Returns:
        The operation finished [BOOL]

    References:
        https://community.bistudio.com/wiki/insert
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_insert_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
    , ["_changeOrdersToInsert", locationNull]
    , ["_index", 0, [0]]
];

_changeOrdersToInsert = switch (typeName _changeOrdersToInsert) do {
    case "LOCATION": { [_changeOrdersToInsert]; };
    case "ARRAY": { _changeOrdersToInsert; };
    default { []; };
};

[0, 0] params ["_countBefore", "_countAfter"];

if (_index >= 0 && count _changeOrdersToInsert > 0) then {

    ([_target, [
        [KPLIB_changeOrders_orders, []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_changeOrders"
    ];

    private _newChangeOrders = _changeOrders select { true; };

    _countBefore = count _changeOrders;

    _newChangeOrders insert [_index, _changeOrdersToInsert, false];

    _countAfter = count _newChangeOrders;

    [_target, [
        [KPLIB_changeOrders_orders, _newChangeOrders]
    ]] call KPLIB_fnc_namespace_getVars;
};

_countAfter > _countBefore;
