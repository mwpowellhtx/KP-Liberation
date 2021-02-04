/*
    KPLIB_fnc_timers_now

    File: fn_timers_now.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:35:28
    Last Update: 2021-02-03 15:35:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the time _now, defaults to returning 'serverTime'

    Parameter(s):
        _now - the time now [SCALAR, default: serverTime]

    Returns:
        The time _now
*/

params [
    ["_now", serverTime, [0]]
];

_now
