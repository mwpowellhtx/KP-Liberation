/*
    KPLIB_fnc_productionSM_onBroadcast

    File: fn_productionSM_onBroadcast.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 19:41:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback handles publishing the CBA production '_namespace' tuple to listening clients
        when it has changed in any way, shape or form.

    Parameter(s):
        NONE

    Returns:
        The event handler is fini [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

private _debug = [
    [
        {KPLIB_param_productionSM_onBroadcast_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onBroadcast_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

params ["_allNamespaces"];

[
    [] call KPLIB_fnc_productionSM_hasBroadcastTimerElapsed
] params [
    "_elapsed"
];

([_objSM, [
    ["KPLIB_production_cids", []]
    , ["KPLIB_production_cidsToPublish", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cids"
    , "_cidsToPublish"
];

if (_debug) then {
    [format ["[fn_productionSM_onBroadcast] Entering: [isNil '_allNamespaces', _elapsed, _cids, _cidsToPublish]: %1"
        , str [isNil '_allNamespaces', _elapsed, _cids, _cidsToPublish]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// Disregard managers that have since dropped off the list
_cidsToPublish = if (_elapsed) then { _cids; } else {
    private _ignoreCids = _cidsToPublish - _cids;
    _cidsToPublish - _ignoreCids;
};

// Broadcast when there are clients listening
if (_elapsed && count _cidsToPublish > 0) then {
    if (isNil "_allNamespaces") then {
        _allNamespaces = [] call KPLIB_fnc_production_getAllNamespaces;
    };
    [
        {
            ([_x, [
                [KPLIB_namespace_changed, false]
            ]] call KPLIB_fnc_namespace_getVars) params [
                "_changed"
            ];
            _changed;
        } count _allNamespaces
    ] params [
        "_changedCount"
    ];

    if (_debug) then {
        [format ["[fn_productionSM_onBroadcast] Publishing: [count _allNamespaces, _changedCount]: %1"
            , str [count _allNamespaces, _changedCount]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: at which point do we even need a "publish" to go along with the broadcast (?)
    if (_changedCount > 0) then {

        private _viewData = _allNamespaces apply {
            [_x] call KPLIB_fnc_production_namespaceToArray;
        };

        {
            private _cid = _x;
            [_x, _viewData] call KPLIB_fnc_productionSM_onPublish;
        } forEach _cidsToPublish;

        // TODO: TBD: really need to have a clear changed namespace API...
        {
            private _namespace = _x;
            [_namespace, [
                [KPLIB_namespace_changed, false]
            ]] call KPLIB_fnc_namespace_setVars;
        } forEach _allNamespaces;
    };
};

if (_debug) then {
    ["[fn_productionSM_onBroadcast] Fini", "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true;
