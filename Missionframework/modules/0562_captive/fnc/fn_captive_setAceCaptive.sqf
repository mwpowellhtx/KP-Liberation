/*
    KPLIB_fnc_captive_setAceCaptive

    File: fn_captive_setAceCaptive.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-11
    Last Update: 2021-06-14 17:19:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks for ACE handcuffed units and rebinds them into the Liberation captive system.

    Parameter(s):
        _unit   - Unit to set in captive mode   [OBJECT, defaults to objNull]
        _state  - State of captive              [BOOLEAN, defaults to false]
        _reason - Reason of the activated event [STRING, defaults to ""]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_unit", objNull, [objNull]],
    ["_state", false, [false]],
    ["_reason", "", [""]]
];

// Exit on missing object
if (isNull _unit) exitWith {
    false
};

if (_reason isEqualTo "SetHandcuffed" && _state) then {
    // Set variable on unit
    _unit setVariable ["KPLIB_captured", [KPLIB_param_captive_timeout] call KPLIB_fnc_timers_create, true];

    // Apply the actions on the unit
    [_unit] remoteExecCall ["KPLIB_fnc_captive_addCaptiveActions", 0, _unit];
};

// Emit global event
["KPLIB_captive_arrested", [_unit]] call CBA_fnc_globalEvent;

true;
