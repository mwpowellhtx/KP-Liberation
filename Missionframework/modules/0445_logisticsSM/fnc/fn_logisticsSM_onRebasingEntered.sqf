/*
    KPLIB_fnc_logisticsSM_onRebasingEntered

    File: fn_logisticsSM_onRebasingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 09:56:25
    Last Update: 2021-03-04 09:56:27
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

params [
    ["_namespace", locationNull, [locationNull]]
];

private _rebased = _namespace getVariable ["KPLIB_logistics_rebased", false];
private _timer = _namespace getVariable ["KPLIB_logistics_timer", +KPLIB_timers_default];

if ((_timer call KPLIB_fnc_timers_isRunning) && !_rebased) then {
    _namespace setVariable ["KPLIB_logistics_timer", (_timer call KPLIB_fnc_timers_rebase)];
    _namespace setVariable ["KPLIB_logistics_rebased", true];
};

true;
