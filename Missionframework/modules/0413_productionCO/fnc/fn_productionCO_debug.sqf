/*
    KPLIB_fnc_productionCO_debug

    File: fn_productionCO_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 08:00:05
    Last Update: 2021-03-17 08:00:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the caller should debug the module.

    Parameter(s):
        _additional - additional debug flags to incorporate into the broader flag [ARRAY, default: []]

    Returns:
        Whether the module ought to run in debug mode [BOOL]
 */

params [
    ["_additional", [], [[]]]
];

[[KPLIB_param_productionCO_debug] + _additional] call KPLIB_fnc_debug_debug;
