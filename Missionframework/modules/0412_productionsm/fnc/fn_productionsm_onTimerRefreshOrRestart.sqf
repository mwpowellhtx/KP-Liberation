/*
    KPLIB_fnc_productionsm_onTimerRefreshOrRestart

    File: fn_productionsm_onTimerRefreshOrRestart.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 11:08:10
    Last Update: 2021-02-22 11:08:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA production namespace production timer. Handles the warm
        refresh cases, as well as the cold boot unstarted cases.

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

private _timer = _namespace getVariable ["_timer", (+KPLIB_timers_default)];

if (_timer call KPLIB_fnc_timers_isRunning) exitWith {

    private _refreshedTimer = _timer call KPLIB_fnc_timers_refresh;
    _namespace setVariable ["_timer", _refreshedTimer];

    if (_debug) then {
        [format ["[fn_productionsm_onTimerRefreshOrRestart] Timer refreshed: [_markerName, _baseMarkerText, _refreshedTimer]: %1"
            , str [_markerName, _baseMarkerText, _refreshedTimer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    true;
};

if (_debug) then {
    [format ["[fn_productionsm_onTimerRefreshOrRestart] Restarting timer: [_markerName, _baseMarkerText]: %1"
        , str [_markerName, _baseMarkerText]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[_namespace] call KPLIB_fnc_productionsm_onTimerRestart;
