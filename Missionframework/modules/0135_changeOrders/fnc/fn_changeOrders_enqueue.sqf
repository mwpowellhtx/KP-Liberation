/*
    KPLIB_fnc_changeOrders_enqueue

    File: fn_changeOrders_enqueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:38:52
    Last Update: 2021-03-06 09:38:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Enqueues a '_target' oriented CHANGE ORDER.

    Parameters:
        _target - an object for which to perform the CO [OBJECT, default: objNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The operation finished [BOOL]

    References:
        https://community.bistudio.com/wiki/pushBack
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_enqueue_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_target", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_changeOrders_enqueue] Entering: [isNull _target, isNull _changeOrder]: %1"
        , str [isNull _target, isNull _changeOrder]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// This is it, enqueue the change order and get out of the way ASAP
([_target, [
    [KPLIB_changeOrders_orders, []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_changeOrders", [], [[]]]
];

private _i = _changeOrders pushBack _changeOrder;

[_target, [
    [KPLIB_changeOrders_orders, _changeOrders]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_changeOrders_enqueue] Fini: [_i]: %1"
        , str [_i]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_i >= 0;
