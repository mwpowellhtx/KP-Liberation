/*
    KPLIB_fnc_logisticsSM_onStandby

    File: fn_logisticsSM_onStandby.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:37:17
    Last Update: 2021-03-05 10:38:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Invokes the LOGISTICS LINE change order processing.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onStandby_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {

    ([_namespace, [
        ["KPLIB_changeOrders", []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_changeOrders"
    ];

    [format ["[fn_logisticsSM_onStandby] Entering: [count _changeOrders]: %1"
        , str [count _changeOrders]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: one step away from being a first-class config function...
[_namespace, { (_this call KPLIB_fnc_changeOrders_process); }] call {
    params [
        ["_target", locationNull, [locationNull]]
        , ["_callback", {}, [{}]]
    ];

    private _defaultStandbyTimer = [KPLIB_logisticsSM_standbyPeriod] call KPLIB_fnc_timers_create;
    private _standbyTimer = _target getVariable ["KPLIB_logistics_standbyTimer", _defaultStandbyTimer];
    _standbyTimer = _standbyTimer call KPLIB_fnc_timers_refresh;

    if (_standbyTimer call KPLIB_fnc_timers_hasElapsed) then {
        [_target] call _callback;
        _standbyTimer = _defaultStandbyTimer call KPLIB_fnc_timers_rebase;
    };

    _target setVariable ["KPLIB_logistics_standbyTimer", _standbyTimer];
};

if (_debug) then {
    ["[fn_logisticsSM_onStandby] Fini", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
