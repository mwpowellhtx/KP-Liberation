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
    , ["_callerName", "fn_changeOrders_tryDequeue", [""]]
];

if (_debug) then {
    [format ["[fn_changeOrders_tryDequeue] Entering: [isNull _target]: %1"
        , str [isNull _target]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

// This is it, enqueue the change order and get out of the way ASAP
([_target, [
    [KPLIB_changeOrders_orders, []]
], _callerName] call KPLIB_fnc_namespace_getVars) params [
    "_changeOrders"
];

private _countBefore = count _changeOrders;

// Return early when there was nothing to dequeu
if (_changeOrders isEqualTo []) exitWith {
    if (_debug) then {
        [format ["[fn_changeOrders_tryDequeue] Empty: [_countBefore]: %1"
            , str [_countBefore]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
    };
    locationNull;
};

if (_debug) then {
    // 'Popping' here, loosely speaking, due to apparent access violations faced with 'deleteAt'
    [format ["[fn_changeOrders_tryDequeue] 'Popping' front element: [_countBefore]: %1"
        , str [_countBefore]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

// // TODO: TBD: this was causing access violations when faced with 2+ enqueued elements
// private _changeOrder = _changeOrders deleteAt 0;

// Only affect the orders variable when there were actual orders present
[_target, [
    [KPLIB_changeOrders_orders, (_changeOrders select [1, count _changeOrders - 1])]
], false, _callerName] call KPLIB_fnc_namespace_setVars;

// Technically, count less one, although we cannot really treat it that way due to AV ...
private _countAfter = count _changeOrders - 1;
private _changeOrder = (_changeOrders#0);

if (_debug) then {
    [format ["[fn_changeOrders_tryDequeue] Fini: [isNull _changeOrder, _countBefore, _countAfter]: %1"
        , str [isNull _changeOrder, _countBefore, _countAfter]], "CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

_changeOrder;
