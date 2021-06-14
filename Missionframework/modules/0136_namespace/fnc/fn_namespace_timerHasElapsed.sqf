#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_timerHasElapsed

    File: fn_namespace_timerHasElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-15 19:03:25
    Last Update: 2021-06-14 16:36:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the specified CBA namespace TIMER has elapsed.

    Parameters:
        _namespace - a CBA namespace [LOCATION, default: locationNull]
        _variableName - the TIMER variable name [STRING, default: ""]
        _defaultValue - a default TIMER when getting the value [TIMER, default: KPLIB_timers_default]
        _readOnly - whether the operation is READ ONLY on the namespace [BOOL, default: false]

    Returns:
        Whether the CBA namespace TIMER has elapsed [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_variableName), "", [""]]
    , [Q(_defaultValue), +KPLIB_timers_default, [[]], 4]
    , [Q(_readOnly), false, [false]]
];

private _debug = MPARAM(_timerHasElapsed_debug)
    || (_namespace getVariable [QMVAR(_timerHasElapsed_debug), false])
    ;

if (_debug) then {
    [format ["[fn_namespace_timerHasElapsed] Entering: [isNull _namespace, _variableName, _defaultValue, _readOnly]: %1"
        , str [isNull _namespace, _variableName, _defaultValue, _readOnly]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

if (isNull _namespace) exitWith { false; };

private _timer = _namespace getVariable [_variableName, _defaultValue];

if (_debug) then {
    [format ["[fn_namespace_timerHasElapsed] Refreshing: [_timer]: %1"
        , str [_timer]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

_timer = _timer call KPLIB_fnc_timers_refresh;

private _elapsed = _timer call KPLIB_fnc_timers_hasElapsed;

if (!_readOnly) then {
    _namespace setVariable [_variableName, _timer];
};

if (_debug) then {
    [format ["[fn_namespace_timerHasElapsed] Entering: [_elapsed, _timer]: %1"
        , str [_elapsed, _timer]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

_elapsed;
