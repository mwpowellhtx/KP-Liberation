/*
    KPLIB_fnc_changeOrders_tryDequeue

    File: fn_changeOrders_tryDequeue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:38:52
    Last Update: 2021-03-06 09:43:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Dequeues a CHANGE ORDER from the '_target' change orders queue. Returns locationNull

    Parameters:
        _target - an object for which to perform the CO [OBJECT, default: objNull]

    Returns:
        The operation finished [BOOL]

    References:
        https://community.bistudio.com/wiki/deleteAt
        https://community.bistudio.com/wiki/locationNull
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_tryDequeue_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_changeOrders_tryDequeue] Entering: [isNull _target]: %1"
        , str [isNull _target]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// This is it, enqueue the change order and get out of the way ASAP
([_target, [
    [KPLIB_changeOrders_orders, []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_changeOrders", [], [[]]]
];

private _changeOrder = if (_changeOrders isEqualTo []) then {locationNull} else {
    _changeOrders deleteAt 0;
};

[_target, [
    [KPLIB_changeOrders_orders, _changeOrders]
], false] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_changeOrders_tryDequeue] Fini: [isNull _changeOrder, count _changeOrders]: %1"
        , str [isNull _changeOrder, count _changeOrders]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_changeOrder;
