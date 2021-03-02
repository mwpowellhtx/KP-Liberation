/*
    KPLIB_fnc_logisticsSM_onPostInit

    File: fn_logisticsSM_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["[fn_logisticsSM_onPostInit] Initializing...", "POST] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)

    // TODO: TBD: refactor as proper function...
    KPLIB_fnc_logisticsSM_getTransportDebit = {
        params [
            ["_transportBaseCost", KPLIB_param_logistics_transportBaseCost, [0]]
        ];
        [
            _transportBaseCost      // supply debit
            , 0                     // ammo debit
            , _transportBaseCost    // fuel debit
        ];
    };

    // TODO: TBD: for now, doing it this way...
    // TODO: TBD: but it opens the mission up for gaming the system...
    KPLIB_fnc_logisticsSM_getTransportCredit = {
        params [
            ["_transportBaseCost", KPLIB_param_logistics_transportBaseCost, [0]]
        ];
        private _factor = KPLIB_param_logistics_transportRecycleValue / 100;
        private _debit = [_transportBaseCost] call KPLIB_fnc_logisticsSM_getTransportDebit;
        _debit apply { _x * _factor; };
    };

    // TODO: TBD: replace "createNamespace" with "createStatemachine"...
    // TODO: TBD: but for now, do this, since we know it is a namespace...
    KPLIB_logisticsSM_namespace = [] call CBA_fnc_createNamespace;

    // Listen for client Logistics Manager dialog announcements...
    ["KPLIB_logisticsSM_onLogisticsMgrOpened", KPLIB_fnc_logisticsSM_onLogisticsMgrOpened] call CBA_fnc_addEventHandler;
    ["KPLIB_logisticsSM_onLogisticsMgrClosed", KPLIB_fnc_logisticsSM_onLogisticsMgrClosed] call CBA_fnc_addEventHandler;

    // Requests for updates may occur secondarily to dialog opening, and regularly during SM publisher states
    ["KPLIB_logisticsSM_publishLines", KPLIB_fnc_logisticsSM_onPublishLines] call CBA_fnc_addEventHandler;
    ["KPLIB_logisticsSM_publishEndpoints", KPLIB_fnc_logisticsSM_onPublishEndpoints] call CBA_fnc_addEventHandler;

    // Allow for line change requests via client server event handling
    ["KPLIB_logisticsSM_requestLineChange", KPLIB_fnc_logisticsSM_onRequestLineChange] call CBA_fnc_addEventHandler;

    // Allow for building and recycling convoy transports
    [KPLIB_logisticsSM_transportRequest_build, KPLIB_fnc_logisticsSM_onRequestTransportBuild] call CBA_fnc_addEventHandler;
    [KPLIB_logisticsSM_transportRequest_recycle, KPLIB_fnc_logisticsSM_onRequestTransportRecycle] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logisticsSM_onPostInit] Initialized", "POST] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
