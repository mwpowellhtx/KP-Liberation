/*
    KPLIB_fnc_productionsm_hasProductionTimerElapsed

    File: fn_productionsm_hasProductionTimerElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 15:42:14
    Last Update: 2021-02-17 15:42:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production '_namespace' is considered elapsed.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether the production timer is considered to be elapsed [BOOL]
 */

private _debug = [["KPLIB_param_productionsm_conditions_debug"]] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_hasProductionTimerElapsed] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _timer = _namespace getVariable ["_timer", KPLIB_timers_default];
private _retval = _timer call KPLIB_fnc_timers_hasElapsed;

if (_debug) then {
    [format ["[fn_productionsm_hasProductionTimerElapsed] Finished: [_retval]: %1"
        , str [_retval]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_retval;
