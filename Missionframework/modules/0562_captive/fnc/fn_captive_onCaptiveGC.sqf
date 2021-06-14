#include "script_component.hpp"
/*
    KPLIB_fnc_captive_onCaptiveGC

    File: fn_captive_onCaptiveGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 11:45:43
    Last Update: 2021-06-14 17:20:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Monitors the UNIT for any of its CAPTIVE phase timers. GC is performed
        when the most recent one has elapsed. Otherwise, relay to the next WAE
        opportunity.

    Parameter(s):
        _unit - a surrendered UNIT to consider [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    ["_unit", objNull, [objNull]]
];

private _debug = MPARAM(_onCaptiveGC_debug)
    || (_unit getVariable [QMVAR(_onCaptiveGC_debug), false])
    ;

// TODO: TBD: this should likely be a CBA wait and exec event (?)
if (_debug) then {
    [format ["[fn_captive_onCaptiveGC] Entering: [isNull _unit]: %1"
        , str [isNull _unit]], "CAPTIVE", true] call KPLIB_fnc_common_log;
};

if (isNull _unit) exitWith { false; };

private _timerPairs = KPLIB_preset_captive_types apply {
    private _varName = format ["KPLIB_%1"];
    [_varName, _unit getVariable [_varName, []]];
};

_timerPairs = _timerPairs select { (_x#1) call KPLIB_fnc_timers_isRunning; };

if (_debug) then {
    [format ["[fn_captive_onCaptiveGC] Selected: [_timerPairs]: %1"
        , str [_timerPairs]], "CAPTIVE", true] call KPLIB_fnc_common_log;
};

// We know what the shape was so we can make this assumption
_timerPairs params [
    [Q(_timerPair), [], [[]]]
];

_timerPair params [
    [Q(_varName), "", [""]]
    , [Q(_timer), [], [[]]]
];

if (_debug) then {
    [format ["[fn_captive_onCaptiveGC] Refreshed: [_varName, _timer]: %1"
        , str [_varName, _timer]], "CAPTIVE", true] call KPLIB_fnc_common_log;
};

if (_varName isEqualTo "") exitWith { false; };

_timer = _timer call KPLIB_fnc_timers_refresh;

/* Then as long as the most recent timer has elapsed, we GC, regardless what it was.
 * The unit can have been interrogated then GC; or have surrendered and not yet been
 * captured, so we GC, and so on.
 */
if (_timer call KPLIB_fnc_timers_hasElapsed) exitWith {

    if (_debug) then {
        ["[fn_captive_onCaptiveGC] Elapsed", "CAPTIVE", true] call KPLIB_fnc_common_log;
    };

    deleteVehicle _unit;
    true;
};

_unit setVariable [_varName, _timer, true];

if (_debug) then {
    ["[fn_captive_onCaptiveGC] Fini", "CAPTIVE", true] call KPLIB_fnc_common_log;
};

true;
