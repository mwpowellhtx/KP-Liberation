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
 */

if (isServer) then {
    ["[fn_logisticsSM_onPostInit] Initializing...", "PRE] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

KPLIB_logisticsSM_onLogisticsMgrOpened  = "KPLIB_logisticsSM_onLogisticsMgrOpened";
KPLIB_logisticsSM_onLogisticsMgrClosed  = "KPLIB_logisticsSM_onLogisticsMgrClosed";
KPLIB_logisticsSM_publishLines          = "KPLIB_logisticsSM_publishLines";
KPLIB_logisticsSM_publishEndpoints      = "KPLIB_logisticsSM_publishEndpoints";

/*
    ----- Module Initialization -----
 */

[] call KPLIB_fnc_logisticsSM_settings;

if (isServer) then {
    // Server section (dedicated and player hosted)

    KPLIB_logisticsSM_configClassNameDefault                    = "KPLIB_logisticsSM";

    KPLIB_logisticsSM_standbyPeriod                             = 1;

    KPLIB_param_logisticsSM_createSM_debug                      = false;
    // KPLIB_param_logisticsSM_gcSM_debug                          = true;
    KPLIB_logisticsSM_onPublishLines_debug                      = false;
    KPLIB_logisticsSM_onBroadcastLines_debug                    = false;
    KPLIB_logisticsSM_onBroadcastLine_debug                     = false;
    KPLIB_logisticsSM_onLogisticsMgrOpened_debug                = false;
    KPLIB_logisticsSM_onLogisticsMgrClosed_debug                = false;

    KPLIB_param_logisticsSM_onRebasingEntered_debug             = false;
    KPLIB_param_logisticsSM_onStandby_debug                     = false;
    KPLIB_param_logisticsSM_onPending_debug                     = false;
    KPLIB_param_logisticsSM_onLoadingEntered_debug              = true;
    KPLIB_param_logisticsSM_onEnRouteEntered_debug              = true;
    KPLIB_param_logisticsSM_onArrivalResetTimer_debug           = true;
    KPLIB_param_logisticsSM_onConfirmReturnMission_debug        = true;
    KPLIB_param_logisticsSM_onAbortComplete_debug               = true;
    KPLIB_param_logisticsSM_toTransit_debug                     = true;
    KPLIB_param_logisticsSM_toPendingUnloading_debug            = true;
    KPLIB_param_logisticsSM_toPendingEnRoute_debug              = true;
    KPLIB_param_logisticsSM_toArriving_debug                    = true;
    KPLIB_param_logisticsSM_onPendingUnloading_debug            = true;
    KPLIB_param_logisticsSM_toStandby_debug                     = true;
    KPLIB_logisticsSM_onTransitStart_debug                      = true;
    KPLIB_param_logisticsSM_onNoOp_debug                        = false;
    KPLIB_param_logisticsSM_tryLoadNextTransport_debug          = true;
    KPLIB_param_logisticsSM_tryUnloadNextTransport_debug        = true;
    KPLIB_param_logisticsSM_onApplyTransaction_debug            = true;

    // Estimated number of CRATES that each CONVOY TRANSPORT may support
    KPLIB_logisticsSM_fullLoads = [
        [1, 1, 1]
        , [2, 1, 0]
        , [2, 0, 1]
        , [1, 2, 0]
        , [0, 2, 1]
        , [1, 0, 2]
        , [0, 1, 2]
        , [3, 0, 0]
        , [0, 3, 0]
        , [0, 0, 3]
    ];

    // We may also support PARTIAL LOADS
    KPLIB_logisticsSM_partialLoads = [
        [1, 1, 0]
        , [1, 0, 1]
        , [0, 1, 1]
        , [2, 0, 0]
        , [0, 2, 0]
        , [0, 0, 2]
        , [1, 0, 0]
        , [0, 1, 0]
        , [0, 0, 1]
    ];

    // TODO: TBD: let's define some valid combinations to consider for the load sequence...
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logisticsSM_onPostInit] Initialized", "PRE] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
