/*
    KPLIB_fnc_productionSM_onPreInit

    File: fn_productionSM_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:55:40
    Last Update: 2021-03-17 14:16:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs module post initialization activites.

    Parameter(s):
        NONE

    Returns:
        Module event handler finished [BOOL]
 */

if (isServer) then {
    ["[fn_productionSM_onPostInit] Initializing...", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_productionSM_settings;

if (isServer) then {
    // Refactored production server side event handlers

    ["KPLIB_updateMarkers", {
        KPLIB_production_namespaces select {
            [_x] call KPLIB_fnc_production_onRenderMarkerText;
            true;
        };
    }] call CBA_fnc_addEventHandler;

    // Client announces to the server that the manager dialog opened/closed...
    [KPLIB_productionSM_productionMgrOpened, KPLIB_fnc_productionSM_onProductionMgrOpened] call CBA_fnc_addEventHandler;
    [KPLIB_productionSM_productionMgrClosed, KPLIB_fnc_productionSM_onProductionMgrClosed] call CBA_fnc_addEventHandler;

    // Client may change the queue via the production manager
    ["KPLIB_productionSM_raiseChangeQueue", KPLIB_fnc_productionCO_onRequestChangeQueue] call CBA_fnc_addEventHandler;

    // // // TODO: TBD: we may not even need this one as long as clients are "re-opening" to gain the refresh...
    // // Publish all of the production states to the requesting client
    // [KPLIB_productionSM_publishProductionState, {
    //     params [
    //         ["_cid", -1, [0]]
    //     ];
    //     [nil, _cid] call KPLIB_fnc_productionSM_onPublish;
    // }] call CBA_fnc_addEventHandler;

    [] call KPLIB_fnc_productionSM_createSM;
};

// TODO: TBD: adding a handful of admin shorthand helpers...
if (true) then {

    // // TODO: TBD: it _does_ work, very well in fact
    //[KPLIB_productionMgr_productionStatePublished, {
    //    params [
    //        ["_state", [], [[]]]
    //    ];
    //    systemChat format ["State received: %1", str _state];
    //    true;
    //}] call CBA_fnc_addEventHandler;

    // [KPLIB_productionMgr_productionStatePublished, {
    //     params [
    //         ["_state", [], [[]]]
    //     ];
    //     systemChat format ["State received: [count _state, systemTime]: %1", str [count _state, systemTime]];
    //     true;
    // }] call CBA_fnc_addEventHandler;

    /*
[] call KPLIB_fnc_admin_productionMgr_toggle;
[] call KPLIB_fnc_admin_productionMgr_refresh;
[KPLIB_productionSM_objSM] call KPLIB_fnc_admin_productionMgr_debug;
    */

    KPLIB_fnc_admin_productionMgr_toggle = {
        params [
            ["_open", true, [true]]
        ];
        if (_open) then {
            [KPLIB_productionSM_productionMgrOpened, [true, clientOwner]] call CBA_fnc_serverEvent;
        } else {
            [KPLIB_productionSM_productionMgrClosed, [clientOwner]] call CBA_fnc_serverEvent;
        };
    };

    KPLIB_fnc_admin_productionMgr_refresh = {
        params [
            ["_namespace", (KPLIB_production_namespaces#0), [locationNull]]
        ];
        [KPLIB_productionSM_publishProductionState, [_namespace]] call CBA_fnc_localEvent;
        _namespace;
    };

    // KPLIB_fnc_admin_productionMgr_debug = {
    //     private _variableNamesDefault = [
    //         "KPLIB_param_productionSM_productionMgr_debug"
    //         //, "KPLIB_param_productionSM_publisher_debug"
    //         , "KPLIB_param_productionSM_publisherEntered_debug"
    //         //, "KPLIB_param_productionSM_publisherCore_debug"
    //         //, "KPLIB_param_productionSM_publisherLeaving_debug"
    //     ];
    //     params [
    //         ["_target", (KPLIB_production_namespaces#0), [locationNull]]
    //         , ["_variableNames", _variableNamesDefault, [[]]]
    //     ];
    //     _variableNames select { _target setVariable [_x, true]; true; };
    //     _target;
    // };

    // Selects the first available namespaces corresponding to the capability mask
    KPLIB_fnc_admin_productionSM_getAvailableCap = {
        params [
            ["_capMask", [false, false, false], [[]]]
        ];
        private _retval = KPLIB_production_namespaces select {
            private _markerName = _x getVariable ["KPLIB_production_markerName", ""];
            private _capability = _x getVariable ["KPLIB_production_capability", KPLIB_production_cap_default];
            (_markerName in KPLIB_sectors_blufor) && (
                _capMask isEqualTo []
                || _capability isEqualTo _capMask
            );
        };
        _retval;
    };

    // Align one of the production sectors for debugging...
    private _onAdminDebugging = {
        params [
            ["_baseMarkerText", "", [""]]
            , ["_enable", false, [false]]
            , ["_leadTime", -1, [0]]
        ];

        private _namespaces = KPLIB_production_namespaces select {
            _baseMarkerText isEqualTo (_x getVariable ["KPLIB_production_baseMarkerText", ""]);
        };

        private _toDebug = [
            ["KPLIB_param_productionSM_onNoOp_debug", _enable]
            , ["KPLIB_param_productionSM_onRebaseEntered_debug", _enable]
            , ["KPLIB_param_productionSM_onStandbyOrPending_debug", _enable]
            , ["KPLIB_param_productionSM_onProcessOrders_debug", _enable]
            , ["KPLIB_param_productionSM_hasRunningTimer_debug", _enable]
            , ["KPLIB_param_productionSM_onUpdateQueue_debug", _enable]
            , ["KPLIB_param_productionSM_tryResourceProduction_debug", _enable]
            , ["KPLIB_param_productionSM_onStandbyOrPendingTransit_debug", _enable]
            , ["KPLIB_param_productionSM_onScheduleTimer_debug", _enable]
        ];

        {
            private _namespace = _x;

            {
                _x params [
                    ["_key", "", [""]]
                    , ["_debug", false, [false]]
                ];
                if (!(_key isEqualTo "")) then {
                    _namespace setVariable [_key, _debug];
                };
            } forEach _toDebug;

            _namespace setVariable ["KPLIB_param_productionSM_preemptLeadTime", _enable];

            if (_leadTime < 0) then {
                _namespace setVariable ["KPLIB_param_productionSM_preemptiveLeadTimeDuration", nil];
            } else {
                _namespace setVariable ["KPLIB_param_productionSM_preemptiveLeadTimeDuration", _leadTime];
            };
        } forEach _namespaces;
    };

    // Allowing for admin debugging ability
    //["Gori Factory"] call _onAdminDebugging;
};

if (isServer) then {
    ["[fn_productionSM_onPostInit] Initialized", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
