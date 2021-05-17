/*
    KPLIB_fnc_common_debug

    File: fn_common_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:37:38
    Last Update: 2021-04-02 14:37:40
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

_additional pushBackUnique {KPLIB_param_common_debug};

[_additional] call KPLIB_fnc_debug_debug;
