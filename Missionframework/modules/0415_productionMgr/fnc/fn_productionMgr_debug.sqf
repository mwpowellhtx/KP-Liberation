/*
    KPLIB_fnc_productionMgr_debug

    File: fn_productionMgr_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:27:15
    Last Update: 2021-02-20 23:12:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether to debug productionMgr assets.

    Parameter(s):
        _additional - any additional flags to capture as a debug barrier [ARRAY, default: []]

    Returns:
        Whether to debug productionMgr assets [BOOL]
*/

//// TODO: TBD: refactor as a proper CBA setting...
//KPLIB_param_productionMgr_debug = true;

params [
    ["_additional", [], [[]]]
];

_additional pushBackUnique "KPLIB_param_production_debug";
_additional pushBackUnique "KPLIB_param_productionMgr_debug";

[_additional] call KPLIB_fnc_debug_debug;
