/*
    KPLIB_fnc_logisticsSM_onRebasingEntered

    File: fn_logisticsSM_onRebasingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 09:56:25
    Last Update: 2021-03-05 18:04:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Rebases the CBA logistics namespace 'KPLIB_logistics_timer' when necessary.
        Lines that are added after the mission has loaded should not require rebasing.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onRebasingEntered_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {
    ["[fn_logisticsSM_onRebasingEntered] Entering", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_logistics_timer", []]
    , ["KPLIB_logistics_shouldRebase", false]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_timer", [], [[]]]
    , ["_shouldRebase", false, [false]]
];

private _rebased = _timer call KPLIB_fnc_timers_rebase;

[_namespace, [
    ["KPLIB_logistics_timer", _rebased]
    , ["KPLIB_logistics_shouldRebase", false]
    , ["KPLIB_logistics_rebased", true]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsSM_onRebasingEntered] Fini: [_timer, _rebased, _shouldRebase]: %1"
        , str [_timer, _rebased, _shouldRebase]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
