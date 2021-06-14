/*
    KPLIB_fnc_captive_onWatchCaptives

    File: fn_captive_onWatchCaptives.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 12:48:51
    Last Update: 2021-06-14 17:19:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Gathers up all the units with at least one of the CAPTIVE timers installed.
        Meaning the UNIT has SURRENDER, CAPTURED, or INTERROGATED, so GC may be
        performed on a cycle irregular from other bits.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/allVariables
        https://community.bistudio.com/wiki/arrayIntersect
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

private _varNames = KPLIB_preset_captive_types apply { toLower format ["KPLIB_%1", _x]; };

// Select all non-PLAYER, ALIVE, units with at least ONE of the variables
private _units = allUnits select {
    !isPlayer _x
        && alive _x
        && _varNames arrayIntersect allVariables _x isNotEqualTo [];
};

private _shuffled = _units call BIS_fnc_arrayShuffle;

{ [_x] call KPLIB_fnc_captive_onCaptiveGC; } forEach _shuffled;

[{ [] call KPLIB_fnc_captive_onWatchCaptives; }, [], KPLIB_param_captive_period] call CBA_fnc_waitAndExecute;
