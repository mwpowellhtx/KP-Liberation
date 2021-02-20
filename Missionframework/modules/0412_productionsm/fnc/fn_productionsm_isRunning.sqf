/*
    KPLIB_fnc_productionsm_isRunning

    File: fn_productionsm_isRunning.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 15:42:14
    Last Update: 2021-02-18 15:38:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production '_namespace' is considered running.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether the production '_namespace' is running [BOOL]
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_isRunning] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _timer = _namespace getVariable ["_timer", KPLIB_timers_default];
private _running = _timer call KPLIB_fnc_timers_isRunning;

if (_debug) then {
    [format ["[fn_productionsm_isRunning] Finished: [_timer, _running]: %1"
        , str [_timer, _running]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_running;
