/*
    KPLIB_fnc_logisticsMgr_onPreInit

    File: fn_logisticsMgr_onPreInit.sqf
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
        // https://community.bistudio.com/wiki/set
        // https://community.bistudio.com/wiki/createHashMap
 */

if (isServer) then {
    ["[fn_logisticsMgr_onPreInit] Initializing...", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

KPLIB_logisticsMgr_onLoad_debug                             = false;
KPLIB_logisticsMgr_lnbLines_onLoad_debug                    = false;
KPLIB_logisticsMgr_lnbLines_onReload_debug                  = false;
KPLIB_logisticsMgr_lnbLines_onLBSelChanged_debug            = false;
KPLIB_logisticsMgr_btnLineAdd_onButtonClick_debug           = false;
KPLIB_logisticsMgr_btnLineRemove_onButtonClick_debug        = false;
KPLIB_logisticsMgr_lnbConvoy_onLoad_debug                   = false;
KPLIB_logisticsMgr_lnbConvoy_onReload_debug                 = false;
KPLIB_logisticsMgr_lnbConvoy_onLBSelChanged_debug           = false;
KPLIB_logisticsMgr_btnTransportAdd_onButtonClick_debug      = false;
KPLIB_logisticsMgr_btnTransportRecycle_onButtonClick_debug  = false;
KPLIB_logisticsMgr_lnbTelemetry_getReport_debug             = false;
KPLIB_logisticsMgr_lnbTelemetry_onLoad_debug                = false;
KPLIB_logisticsMgr_lnbTelemetry_onClear_debug               = false;
KPLIB_logisticsMgr_lnbTelemetry_onRefresh_debug             = false;
KPLIB_logisticsMgr_btnRefresh_onButtonClick_debug           = false;
KPLIB_logisticsMgr_cboEndpoint_onLoad_debug                 = false;
KPLIB_logisticsMgr_cboEndpoint_onReload_debug               = false;
KPLIB_logisticsMgr_cboEndpoint_getSelectedEndpoint_debug    = false;
KPLIB_logisticsMgr_cboEndpoint_onLBSelChanged_debug         = false;
KPLIB_logisticsMgr_onLinesPublished_debug                   = false;
KPLIB_logisticsMgr_onEndpointsPublished_debug               = false;
KPLIB_logisticsMgr_onUnload_debug                           = false;

/*
    ----- Module Initialization -----
 */

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section

    KPLIB_logistics_telemetry_hashMap_status            = "_status";
    KPLIB_logistics_telemetry_hashMap_duration          = "_duration";
    KPLIB_logistics_telemetry_hashMap_elapsedTime       = "_elapsedTime";
    KPLIB_logistics_telemetry_hashMap_timeRemaining     = "_timeRemaining";
    KPLIB_logistics_telemetry_hashMap_transportSpeed    = "_transportSpeed";

    KPLIB_logisticsMgr_cboEndpointHashMap = [] call {
        private _retval = createHashMap;
        _retval set ["ALPHA", "KPLIB_logisticsMgr_cboAlpha"];
        _retval set ["BRAVO", "KPLIB_logisticsMgr_cboBravo"];
        _retval;
    };
};

if (isServer) then {
    ["[fn_logisticsMgr_onPreInit] Initialized", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
