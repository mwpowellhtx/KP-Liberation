/*
    KPLIB_fnc_productionsm_raiseChangeQueue

    File: fn_productionsm_raiseChangeQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-02-19 13:50:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Raises the 'KPLIB_productionsm_onAddCapability' event with the CBA production statemachine.

    Parameter(s):
        _targetMarker - the target factory sector, i.e. '_markerName', affected by the request
        _targetQueue - the target '_queue' being changed on the CBA production '_namespace' [ARRAY, default: []]
        _cid - the client identifier used to invoke client side callbacks

    Returns:

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

private _debug = [
    [
        "KPLIB_param_productionsm_raisers_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_targetMarker", "", [""]]
    , ["_targetQueue", [], [[]]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionsm_raiseChangeQueue] Entering: [_targetMarker, _targetQueue, _cid]: %1"
        , str [_targetMarker, _targetQueue, _cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: may initially reject the request...
if (_cid < 0
    || _targetMarker isEqualTo ""
    || !([_targetQueue] call KPLIB_fnc_production_verifyQueue)) exitWith {

    if (_debug) then {
        ["[fn_productionsm_raiseChangeQueue] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    false;
};

private _namespace = [_targetMarker] call KPLIB_fnc_productionsm_getNamespace;

// Present a the change order and get out of the way
private _changeOrder = [
    _cid
    , "_queue" // ["_variableName", ["_defaultValue", nil]]
    , _targetQueue // given the new '_queue' value 'as-is' by the client
    , KPLIB_fnc_productionsm_onChangeQueueRaised
];

[_namespace, _changeOrder] call KPLIB_fnc_productionsm_enqueueChangeOrder;

if (_debug) then {
    [format ["[fn_productionsm_raiseChangeQueue] Change order enqueued: [_cid, _variableSpec, _targetQueue]: %1"
        , str [(_changeOrder#0), (_changeOrder#1), (_changeOrder#2)]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _eventName = "KPLIB_productionsm_onChangeOrder";

[_eventName, [_namespace]] call CBA_fnc_localEvent;

if (_debug) then {
    [format ["[fn_productionsm_raiseChangeQueue] Finished: ['%1']"
        , _eventName], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
