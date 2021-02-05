/*
    KPLIB_fnc_production_debug

    File: fn_production_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:35:16
    Last Update: 2021-02-04 13:35:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the caller should conduct debugging.

    Parameter(s):
        _additional - Any additional flags informing the debug condition [ARRAY, default: []]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_additional", [], [[]]]
];

// Which requires for settings to have been initialized prior to landing here
private _conditions = [
    missionNamespace getVariable ["KPLIB_param_production_debug", false]
];

_conditions append _additional;

[_conditions] call KPLIB_fnc_debug_debug;
