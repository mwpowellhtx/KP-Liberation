#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_debug

    File: fn_hudDispatchSM_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the caller should debug.

    Parameters:
        _additional - additional conditions to include [ARRAY, default: []]

    Returns:
        Whether the caller should debug [BOOL]
 */

params [
    [Q(_additional), [], [[]]]
];

_additional pushBackUnique {MPARAM(_debug)};

[_additional] call KPLIB_fnc_debug_debug;
