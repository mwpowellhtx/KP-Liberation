/*
    KPLIB_fnc_productionSM_onUpdateQueue

    File: fn_productionSM_onUpdateQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 18:04:32
    Last Update: 2021-03-17 18:04:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles CBA PRODUCTION QUEUE bookkeeping following the most recent PRODUCTION
        state attempt to produce and store a next resource.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onStandbyOrPendingTransit", [""]]
];

// TODO: TBD: may also want to align specific storage objects along debug...
private _debug = [
    [
        {KPLIB_param_productionSM_onUpdateQueue_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onUpdateQueue_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onUpdateQueue_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

if (_debug) then {
    [format ["[fn_productionSM_onPreInit] Entering: [isNull _namespace, _callerName]: %1"
        , str [isNull _namespace, _callerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_production_queue", []]
    , ["KPLIB_production_markerName", ""]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_lastResource", -1]
    , ["KPLIB_production_capability", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_queue"
    , "_markerName"
    , "_baseMarkerText"
    , "_lastResource"
    , "_cap"
];

if (_debug) then {
    [format ["[fn_productionSM_onPreInit] Evaluating: [_markerName, _baseMarkerText, _queue, _lastResource, _cap]: %1"
        , str [_markerName, _baseMarkerText, _queue, _lastResource, _cap]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[
    _lastResource in KPLIB_resources_indexes
    , _queue isEqualTo []
    , KPLIB_param_production_rescheduleLastResource
] params [
    "_produced"
    , "_complete"
    , "_reschedule"
];

if (_debug) then {
    [format ["[fn_productionSM_onPreInit] Updating: [_produced, _complete, _reschedule]: %1"
        , str [_produced, _complete, _reschedule]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Identify queued production that are still in the cap
_queue = _queue select { (_x in KPLIB_resources_indexes) } select { (_cap select _x); };

// Append the next element on deck when appropriate to do so
if (_produced && _complete && _reschedule) then {
    if (_cap select _lastResource) then {
        _queue = _queue + [_lastResource]
    };
};

[_namespace, [
    ["KPLIB_production_queue", _queue]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    ["[fn_productionSM_onPreInit] Fini", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
