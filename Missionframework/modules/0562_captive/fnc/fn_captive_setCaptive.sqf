/*
    KPLIB_fnc_captive_setCaptive

    File: fn_captive_setCaptive.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-11
    Last Update: 2021-06-14 17:19:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets an unit into captive mode.

    Parameter(s):
        _unit - Unit to set in captive mode [OBJECT, defaults to objNull]

    Returns:
        Unit set into captive mode [BOOL]
*/

params [
    ["_unit", objNull, [objNull]]
];

// Exit on missing object
if (isNull _unit) exitWith {
    false
};

// Set variable on unit
_unit setVariable ["KPLIB_captured", [KPLIB_param_captive_timeout] call KPLIB_fnc_timers_create, true];

// Emit global event
["KPLIB_captive_arrested", [_unit]] call CBA_fnc_globalEvent;

true
