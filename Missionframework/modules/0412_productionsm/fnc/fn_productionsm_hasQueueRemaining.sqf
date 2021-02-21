/*
    KPLIB_fnc_productionsm_hasQueueRemaining

    File: fn_productionsm_hasQueueRemaining.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 14:44:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production '_namespace' '_queue' has elements remaining.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether the production timer is considered to be elapsed [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_conditions_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

// TODO: TBD: fill in this gap...
params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_hasQueueRemaining] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Meaning simply, if there is are enqueued resources, then production can be scheduled
private _queue = _namespace getVariable ["_queue", []];

if (_debug) then {
    [format ["[fn_productionsm_hasQueueRemaining] Finished: [count _queue]: %1"
        , str [count _queue]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

count _queue > 0;
