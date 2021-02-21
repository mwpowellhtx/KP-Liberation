/*
    KPLIB_fnc_productionsm_onPreInit

    File: fn_productionsm_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:55:40
    Last Update: 2021-02-18 20:55:43
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
    ["[fn_productionsm_onPostInit] Initializing...", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Refactored production server side event handlers

    // Client may add capability to a target factory sector
    ["KPLIB_productionsm_raiseAddCapability", KPLIB_fnc_productionsm_raiseAddCapability] call CBA_fnc_addEventHandler;

    // Client announces to the server that the manager dialog opened/closed...
    ["KPLIB_productionsm_onProductionMgrOpened", KPLIB_fnc_productionsm_onProductionMgrOpened] call CBA_fnc_addEventHandler;
    ["KPLIB_productionsm_onProductionMgrClosed", KPLIB_fnc_productionsm_onProductionMgrClosed] call CBA_fnc_addEventHandler;

    // Client may change the queue via the production manager
    ["KPLIB_productionsm_raiseChangeQueue", KPLIB_fnc_productionsm_raiseChangeQueue] call CBA_fnc_addEventHandler;

    [] call KPLIB_fnc_productionsm_createSM;
};

if (isServer) then {
    ["[fn_productionsm_onPostInit] Initializing...", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: adding a handful of admin shorthand helpers...
if (true) then {

    // // TODO: TBD: it _does_ work, very well in fact
    //["KPLIB_productionMgr_onProductionStatePublished", {
    //    params [
    //        ["_state", [], [[]]]
    //    ];
    //    systemChat format ["State received: %1", str _state];
    //    true;
    //}] call CBA_fnc_addEventHandler;

    // ["KPLIB_productionMgr_onProductionStatePublished", {
    //     params [
    //         ["_state", [], [[]]]
    //     ];
    //     systemChat format ["State received: [count _state, systemTime]: %1", str [count _state, systemTime]];
    //     true;
    // }] call CBA_fnc_addEventHandler;

    /*
[] call KPLIB_fnc_admin_productionMgr_toggle;
[] call KPLIB_fnc_admin_productionMgr_refresh;
[KPLIB_productionsm_objSM] call KPLIB_fnc_admin_productionMgr_debug;
    */

    KPLIB_fnc_admin_productionMgr_toggle = {
        params [
            ["_open", true, [true]]
        ];
        if (_open) then {
            ["KPLIB_productionsm_onProductionMgrOpened", [clientOwner]] call CBA_fnc_serverEvent;
        } else {
            ["KPLIB_productionsm_onProductionMgrClosed", [clientOwner]] call CBA_fnc_serverEvent;
        };
    };

    KPLIB_fnc_admin_productionMgr_refresh = {
        params [
            ["_namespace", (KPLIB_production_namespaces#0), [locationNull]]
        ];
        ["KPLIB_productionsm_onPublishProductionState", [_namespace]] call CBA_fnc_localEvent;
        _namespace;
    };

    KPLIB_fnc_admin_productionMgr_debug = {
        private _variableNamesDefault = [
            "KPLIB_param_productionsm_productionMgr_debug"
            //, "KPLIB_param_productionsm_publisher_debug"
            , "KPLIB_param_productionsm_publisherEntered_debug"
            //, "KPLIB_param_productionsm_publisherCore_debug"
            //, "KPLIB_param_productionsm_publisherLeaving_debug"
        ];

        params [
            ["_target", (KPLIB_production_namespaces#0), [locationNull]]
            , ["_variableNames", _variableNamesDefault, [[]]]
        ];

        _variableNames select { _target setVariable [_x, true]; true; };

        _target;
    };
};

true;
