/*
    KPLIB_fnc_productionCO_onRequestChangeQueue

    File: fn_productionCO_onRequestChangeQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-03-17 08:57:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Prepares the CHANGE QUEUE change order for processing during the next STANDBY or PENDING cycle.

    Parameter(s):
        _targetMarker - the target factory sector, i.e. '_markerName', affected by the request
        _queueRequest - the requested queue to use following the change [ARRAY, default: []]
        _cid - the client identifier used to invoke client side callbacks

    Returns:
        The callback finished [BOOL]
 */

params [
    ["_targetMarker", "", [""]]
    , ["_queueRequest", [], [[]]]
    , ["_cid", -1, [0]]
];

private _namespace = [_targetMarker] call KPLIB_fnc_production_getNamespaceByMarker;

private _debug = [
    [
        {KPLIB_param_productionCO_onRequest_debug}
        , {KPLIB_param_productionCO_onRequestChangeQueue_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onRequest_debug", false]}
        , {_namespace getVariable ["KPLIB_param_productionCO_onRequestChangeQueue_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

if (_debug) then {
    [format ["[fn_productionCO_onRequestChangeQueue] Entering: [_targetMarker, _queueRequest, isNull _namespace, _cid]: %1"
        , str [_targetMarker, _queueRequest, isNull _namespace, _cid]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// Do a little light validation of the request prior to submitting the change order itself
if (isNull _namespace || !([_queueRequest] call KPLIB_fnc_production_verifyQueue)) exitWith {
    if (_debug) then {
        ["[fn_productionCO_onRequestChangeQueue] Rejected", "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _changeOrder = [{
    params [
        ["_changeOrder", locationNull, [locationNull]]
    ];

    [_changeOrder, [
        ["KPLIB_production_cid", _cid]
        , ["KPLIB_production_queueCandidate", _queueRequest]
        , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_productionCO_onChangeQueue]
        , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_productionCO_onChangeQueueEntering]
        , [KPLIB_changeOrders_onChangeOrderComplete, {
            // TODO: TBD: could refactor as proper first class function...
            // TODO: TBD: bottom line here is to ensure that the client requesting the change has an update
            params [
                ["_target", locationNull, [locationNull]]
                , ["_changeOrder", locationNull, [locationNull]]
            ];
            ([_changeOrder, [
                ["KPLIB_production_cid", -1]
            ]] call KPLIB_fnc_namespace_getVars) params [
                "_cid"
            ];
            ([KPLIB_productionSM_objSM, [
                ["KPLIB_production_cidsToPublish", []]
            ]] call KPLIB_fnc_namespace_getVars) params [
                "_cidsToPublish"
            ];
            _cidsToPublish pushBackUnique _cid;
            [KPLIB_productionSM_objSM, [
                ["KPLIB_production_cidsToPublish", _cidsToPublish]
            ]] call KPLIB_fnc_namespace_setVars;
            [] call KPLIB_fnc_productionSM_onBroadcast;
        }]
    ]] call KPLIB_fnc_namespace_setVars;

}] call KPLIB_fnc_changeOrders_create;

[_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue;

if (_debug) then {
    ["[fn_productionCO_onRequestChangeQueue] Fini", "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true;
