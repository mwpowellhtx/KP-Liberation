#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onStandbyEntered

    File: fn_hudDispatchSM_onStandbyEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        STANDBY 'onStateEntered' event handler.

    Parameters:
        _player - the player for whom STANDBY state has entered [OBJECT, default: objNull]

    Returns:
        The event handler has fnished [BOOL]
 */

private _debug = [
    [
        {MPARAM(_hudDispatchSM_onStandbyEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudDispatchSM_onStandbyEntered] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Starts running a new timer with every cycle
_player setVariable [QMVAR(_dispatchTimer), [MPARAM(_dispatchPeriod)] call KPLIB_fnc_timers_create];

if (_debug) then {
    ["[fn_hudDispatchSM_onStandbyEntered] Fini", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
