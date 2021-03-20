#include "script_component.hpp"
/*
    KPLIB_fnc_missions_debug

    File: fn_missions_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 01:57:24
    Last Update: 2021-03-20 01:57:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the caller should conduct debugging.

    Parameter(s):
        _additional - Any additional flags informing the debug condition [ARRAY, default: []]

    Returns:
        Whether the caller should conduct debugging [BOOL]
 */

params [
    ["_additional", [], [[]]]
];

_additional pushBackUnique {MSPARAM(_debug)};

[_additional] call KPLIB_fnc_debug_debug;
