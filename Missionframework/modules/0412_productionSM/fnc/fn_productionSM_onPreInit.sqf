/*
    KPLIB_fnc_productionSM_onPreInit

    File: fn_productionSM_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:55:30
    Last Update: 2021-03-18 16:07:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs module pre initialization activites.

    Parameter(s):
        NONE

    Returns:
        Module event handler finished [BOOL]
 */

if (isServer) then {
    ["[fn_productionSM_onPreInit] Initializing...", "PRE] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_productionSM_settings;


KPLIB_productionSM_productionMgrOpened                          = "KPLIB_productionSM_productionMgrOpened";
KPLIB_productionSM_productionMgrClosed                          = "KPLIB_productionSM_productionMgrClosed";
KPLIB_productionSM_publishProductionState                       = "KPLIB_productionSM_publishProductionState";

if (isServer) then {

    KPLIB_param_productionSM_debug                              = false;
    KPLIB_param_productionSM_createSM_debug                     = false;
    KPLIB_param_productionSM_onGetList_debug                    = false;
    KPLIB_param_productionSM_onBroadcast_debug                  = false;
    KPLIB_param_productionSM_onPublish_debug                    = false;
    KPLIB_param_productionSM_onNoOp_debug                       = false;
    KPLIB_param_productionSM_onProductionMgrOpened_debug        = false;
    KPLIB_param_productionSM_onProductionMgrClosed_debug        = false;
    KPLIB_param_productionSM_onRebaseEntered_debug              = false;
    KPLIB_param_productionSM_onStandbyOrPending_debug           = false;
    KPLIB_param_productionSM_onProcessOrders_debug              = false;
    KPLIB_param_productionSM_hasRunningTimer_debug              = false;
    KPLIB_param_productionSM_onUpdateQueue_debug                = false;
    KPLIB_param_productionSM_tryResourceProduction_debug        = false;
    KPLIB_param_productionSM_getProductionTimerDuration_debug   = false;
    KPLIB_param_productionSM_onStandbyOrPendingTransit_debug    = false;
    KPLIB_param_productionSM_onScheduleTimer_debug              = false;

    KPLIB_productionSM_objSM                                    = locationNull;
    KPLIB_productionSM_configClassNameDefault                   = "KPLIB_productionSM";
};

if (isServer) then {
    ["[fn_productionSM_onPreInit] Initialized", "PRE] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
