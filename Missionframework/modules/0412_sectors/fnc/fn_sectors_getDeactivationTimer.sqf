#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getDeactivationTimer

    File: fn_sectors_getDeactivationTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-11 14:09:08
    Last Update: 2021-06-14 16:50:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the DEACTIVATION TIMER corresponding to the TIMEOUT.

    Parameter(s):
        _timeout - a TIMEOUT informing the TIMER [SCALAR, default: KPLIB_param_sectors_deactivationTimeout]

    Returns:
        A DEACTIVATION TIMER corresponding to the TIMEOUT [ARRAY]
 */

params [
    [Q(_timeout), MPARAM(_deactivationTimeout), [0]]
];

private _timer = [_timeout] call KPLIB_fnc_timers_create;

_timer;
