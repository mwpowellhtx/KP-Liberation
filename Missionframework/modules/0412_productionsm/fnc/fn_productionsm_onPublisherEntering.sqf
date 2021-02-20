/*
    KPLIB_fnc_productionsm_onPublisherEntering

    File: fn_productionsm_onPublisherEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 15:28:08
    Last Update: 2021-02-19 15:28:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback which handles creating or refreshing the Publisher timer for the
        CBA production '_namespace'.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The event handler is fini [BOOL]
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onPublisherEntering] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _timer = _namespace getVariable ["_publisherTimer", (+KPLIB_timers_default)];

_timer = if (_timer call KPLIB_fnc_timers_isRunning) then {
    _timer call KPLIB_fnc_timers_refresh;
} else {
    [KPLIB_param_productionsm_publisherPeriodSeconds] call KPLIB_fnc_timers_create;
};

_namespace setVariable ["_publisherTimer", _timer];

if (_debug) then {
    ["[fn_productionsm_onPublisherEntering] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
