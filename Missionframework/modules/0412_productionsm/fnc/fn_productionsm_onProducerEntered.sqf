/*
    KPLIB_fnc_productionsm_onProducerEntered

    File: fn_productionsm_onProducerEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 17:14:14
    Last Update: 2021-02-22 17:14:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The sole purpose of this 'onStateEntered' event handler is to stage the
        'KPLIB_fnc_productionsm_onProducingResourceRaised' change order for immediate
        attention, and to get out of the way of that operation as quickly as possible.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_producer_debug"
        , "KPLIB_param_productionsm_producerEntered_debug"
        , "KPLIB_param_productionsm_changeOrders_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_producer_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_producerEntered_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_changeOrders_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
private _queue = _namespace getVariable ["_queue", []];

// There is not much to these state event handler, but this is the key:
private _queueAfter = if (_queue isEqualTo []) then {[];} else {
    // Meaning that we want the first item to have been peeled off to production
    _queue select [1, count _queue - 1];
};

if (_debug) then {
    [format ["[fn_productionsm_onProducerEntered] Entering: [_markerName, _baseMarkerText, _queue, _queueAfter]: %1"
        , str [_markerName, _baseMarkerText, _queue, _queueAfter]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: while we are debugging... we'll get there, but for now let's focus on the other SM bits...
if (!KPLIB_param_productionsm_productionEnabled) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onProducerEntered] Production disabled: [_markerName, _baseMarkerText, _queue, _queueAfter]: %1"
            , str [_markerName, _baseMarkerText, _queue, _queueAfter]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    true;
};

// Present a the change order and get out of the way as quickly as possible
private _changeOrder = [
    -1 // There are no client identifiers involved in a server side change order
    , "_queue" // ["_variableName", ["_defaultValue", nil]]
    , _queueAfter // The desired queue after resource production success
    , KPLIB_fnc_productionsm_onProducingResourceRaised
];

[_namespace, _changeOrder] call KPLIB_fnc_productionsm_enqueueChangeOrder;

if (_debug) then {
    [format ["[fn_productionsm_onProducerEntered] Change order enqueued: [_markerName, _baseMarkerText, _variableSpec, _queueAfter]: %1"
        , str [_markerName, _baseMarkerText, (_changeOrder#1), (_changeOrder#2)]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _eventName = "KPLIB_productionsm_onChangeOrder";

[_eventName, [_namespace]] call CBA_fnc_localEvent;

true;
