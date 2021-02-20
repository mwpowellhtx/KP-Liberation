/*
    KPLIB_fnc_productionsm_onPublisherLeaving

    File: fn_productionsm_onPublisherLeaving.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 15:35:49
    Last Update: 2021-02-19 15:35:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Installs a freshly running timer given the CBA production '_namespace' when
        the previous one has elapsed.

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
    [format ["[fn_productionsm_onPublisherLeaving] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _timer = _namespace getVariable ["_publisherTimer", []];

if (_timer call KPLIB_fnc_timers_hasElapsed) then {
    _timer = [KPLIB_param_productionsm_publisherPeriodSeconds] call KPLIB_fnc_timers_create;
    _namespace setVariable ["_publisherTimer", _timer];
};

// And catch up the client identifiers
private _cids = _namespace getVariable ["_cids", []];
_namespace setVariable ["_previousCids", (+_cids)];

// Also clear any that were 'forced'
_namespace setVariable ["_forcedCids", []];

if (_debug) then {
    ["[fn_productionsm_onPublisherLeaving] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
