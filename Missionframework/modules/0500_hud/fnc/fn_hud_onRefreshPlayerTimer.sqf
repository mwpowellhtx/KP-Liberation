
#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onRefreshPlayerTimer

    File: fn_hud_onRefreshPlayerTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the named timer for the PLAYER.

    Parameters:
        _player - the player for whom an affixed timer may be refreshed
            [OBJECT, default: objNull]
        _timerName - the variable name affixed to the player being refreshed
            [STRING, default: KPLIB_hudDispatchSM_dispatchTimer]
        _timerPeriod - a timer period used to create a default timer shape
            [SCALAR, default: KPLIB_hudDispatchSM_dispatchPeriod]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {MPARAM(_onRefreshPlayerTimer_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_timerName), KPLIB_hudDispatchSM_dispatchTimer, [""]]
    , [Q(_timerPeriod), KPLIB_hudDispatchSM_dispatchPeriod, [0]]
];

private _defaultTimer = [_timerPeriod] call KPLIB_fnc_timers_create;

private _timer = _player getVariable [_timerName, _defaultTimer];

_timer = _timer call KPLIB_fnc_timers_refresh;

_player setVariable [_timerName, _timer];

// Just refresh the timer that is all
true;
