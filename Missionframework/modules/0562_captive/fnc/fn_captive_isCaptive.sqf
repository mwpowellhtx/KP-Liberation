/*
    KPLIB_fnc_captive_isCaptive

    File: fn_captive_isCaptive.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 12:00:29
    Last Update: 2021-06-14 17:20:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the OBJECT is considered 'KPLIB_surrender', 'KPLIB_captured',
        or 'KPLIB_interrogated'.

    Parameter(s):
        _object - an OBJECT to consider [OBJECT, default: objNull]
        _type - a captive TYPE to consider, case-insensitive [STRING, default: 'surrender']

    Returns:
        Whether the OBJECT is considered to be surrendered [BOOL]
*/

params [
    ["_object", objNull, [objNull]]
    , ["_type", "surrender", [""]]
];

// The TYPE was invalid, case-insensitive
if (KPLIB_preset_captive_types findIf { _x == _type } < 0) exitWith {
    false;
};

// The corresponding TIME may not be set after all
private _timer = _object getVariable [format ["KPLIB_%1", _type], []];

_timer call KPLIB_fnc_timers_isRunning;
