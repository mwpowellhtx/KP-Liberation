/*
    KPLIB_fnc_productionSM_tryResourceProduction

    File: fn_productionSM_tryResourceProduction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 17:48:54
    Last Update: 2021-03-17 17:48:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Tries to produce the next resource in the CBA PRODUCTION namespace QUEUE.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether the resource credit was successfully processed [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_range", KPLIB_param_sectorCapRange, [0]]
];

// TODO: TBD: may also want to align specific storage objects along debug...
private _debug = [
    [
        {KPLIB_param_productionSM_tryResourceProduction_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_tryResourceProduction_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_tryResourceProduction_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    , ["KPLIB_production_queue", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_queue"
];

// Identify the LAST RESOURCE and REMAINING QUEUE
[
    (_queue#0)
    , _queue select [1, count _queue - 1]
] params [
    "_lastResource"
    , "_remaining"
];

// Assembly the PRODUCTION CREDIT to be 'refunded' to the factory sector
private _credit = KPLIB_resources_indexes apply {
    if (!(_x isEqualTo _lastResource)) then { 0; } else {
        KPLIB_param_production_yield;
    };
};

if (_debug) then {
    [format ["[fn_productionSM_tryResourceProduction] Trying: [isNull _namespace, _range, _markerName, _queue, _lastResource, _remaining, _credit]: %1"
        , str [isNull _namespace, _range, _markerName, _queue, _lastResource, _remaining, _credit]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Get BEFORE and AFTER RESOURCE TOTAL snapshots around the REFUNDED CREDIT
[
    [_markerName, _range] call KPLIB_fnc_resources_getResTotal
    , ([_markerName] + _credit + [_range]) call KPLIB_fnc_resources_refund
    , [_markerName, _range] call KPLIB_fnc_resources_getResTotal
] params [
    "_totalBefore"
    , "_credited"
    , "_totalAfter"
];

/* Which outcome means, production:
 *      1. Unsuccessful, maintain the previous queue, keep timing
 *      2. Successful, reschedule with the new queue in hand, also report the _lastResource produced
 */
if (_totalAfter isEqualTo _totalBefore) then {
    _lastResource = -1;
} else {
    _queue = _remaining;
};

if (_debug) then {
    [format ["[fn_productionSM_tryResourceProduction] Tried: [_markerName, _credited, _totalBefore, _totalAfter, _queue, _lastResource]: %1"
        , str [_markerName, _credited, _totalBefore, _totalAfter, _queue, _lastResource]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[_namespace, [
    ["KPLIB_production_queue", _queue]
    , ["KPLIB_production_lastResource", _lastResource]
]] call KPLIB_fnc_namespace_setVars;

true;
