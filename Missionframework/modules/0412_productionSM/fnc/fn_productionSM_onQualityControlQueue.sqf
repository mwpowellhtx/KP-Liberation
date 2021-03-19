/*
    KPLIB_fnc_productionSM_onQualityControlQueue

    File: fn_productionSM_onQualityControlQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-18 20:41:09
    Last Update: 2021-03-18 20:41:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Ensures that the queue has QC taken care of. Leaves timers alone.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onQualityControlQueue", [""]]
];

// TODO: TBD: may also want to align specific storage objects along debug...
private _debug = [
    [
        {KPLIB_param_productionSM_onQualityControlQueue_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onQualityControlQueue_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onQualityControlQueue_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

if (_debug) then {
    [format ["[fn_productionSM_onQualityControlQueue] Entering: [isNull _namespace, _callerName]: %1"
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
    [format ["[fn_productionSM_onQualityControlQueue] Quality control: [_markerName, _baseMarkerText, _queue, _cap]: %1"
        , str [_markerName, _baseMarkerText, _queue, _lastResource, _cap]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: really, though, we ought not to have seen a -1 "last resource" land in queue at all...
private _qc = _queue select { (_x in KPLIB_resources_indexes) } select { (_cap select _x); };

// If we QC'ed and there was a correction, then
if (!(_qc isEqualTo _queue)) then {

    // Since we are here as a last ditch effort then may restart the timer
    private _timer = if (_qc isEqualTo []) then { +KPLIB_timers_default; } else {
        private _duration = [_namespace] call KPLIB_fnc_productionSM_getProductionTimerDuration;
        [_duration] call KPLIB_fnc_timers_create;
    };

    [_namespace, [
        ["KPLIB_production_queue", _qc]
        , ["KPLIB_production_lastResource", -1]
        , ["KPLIB_production_timer", _timer]
    ]] call KPLIB_fnc_namespace_setVars;
};

if (_debug) then {
    ["[fn_productionSM_onQualityControlQueue] Fini", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
