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

// Dots connecting across client server boundaries including UI event handling scaffolding
KPLIB_logisticsSM_transportRequest_build        = "KPLIB_logisticsSM_requestTransportBuild";
KPLIB_logisticsSM_transportRequest_recycle      = "KPLIB_logisticsSM_recycleTransportBuild";


/*
    ----- Module Initialization -----
 */

[] call KPLIB_fnc_logisticsSM_settings;

if (isServer) then {
    // Server section (dedicated and player hosted)

    KPLIB_logisticsSM_onPublishLines_debug              = false;
    KPLIB_logisticsSM_onBroadcastLines_debug            = false;
    KPLIB_logisticsSM_onLogisticsMgrOpened_debug        = false;
    KPLIB_logisticsSM_onLogisticsMgrClosed_debug        = false;
    KPLIB_logisticsSM_onRequestLineChange_debug         = false;
    KPLIB_logisticsSM_onRequestTransportBuild_debug     = false;
    KPLIB_logisticsSM_onRequestTransportRecycle_debug   = false;
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
