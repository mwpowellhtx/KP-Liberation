
#include "script_component.hpp"
/*
    KPLIB_fnc_hud_hasPlayerTimerElapsed

    File: fn_hud_hasPlayerTimerElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:02:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the HUD player timer has elapsed.

    Parameters:
        _player - a player for whom timer may have elapsed [OBJECT, default: objNull]
        _timerName - the timer name in question [STRING, default: KPLIB_hudSM_dispatchTimer]

    Returns:
        Whether the HUD player timer has elapsed [BOOL]
 */

private _debug = [
    [
        {MPARAM(_hasPlayerTimerElapsed_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_timerName), KPLIB_hudSM_dispatchTimer, [""]]
];

private _timer = _player getVariable [_timerName, +KPLIB_timers_default];

private _elapsed = _timer call KPLIB_fnc_timers_hasElapsed;

_elapsed;
