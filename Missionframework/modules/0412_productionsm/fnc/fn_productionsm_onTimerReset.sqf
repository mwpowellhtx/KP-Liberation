/*
    KPLIB_fnc_productionsm_onTimerReset

    File: fn_productionsm_onTimerReset.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 11:03:26
    Last Update: 2021-02-22 11:03:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Restart the CBA production namespace production timer.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        When the event handler is finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

[
    [
        "KPLIB_param_productionsm_timer_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_timer_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", ""];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

private _resetTimer = +(KPLIB_timers_default);

_namespace setVariable ["_timer", _resetTimer];

if (_debug) then {
    [format ["[fn_productionsm_onTimerReset] Timer restarted: [_markerName, _baseMarkerText, _resetTimer]: %1"
        , str [_markerName, _baseMarkerText, _resetTimer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
