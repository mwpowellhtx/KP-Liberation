/*
    KPLIB_fnc_logisticsCO_onPreInit

    File: fn_logisticsCO_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 10:18:44
    Last Update: 2021-03-13 16:55:48
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
    ["[fn_logisticsCO_onPreInit] Initializing...", "PRE] [LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

// Dots connecting across client server boundaries including UI event handling scaffolding
KPLIB_logisticsCO_requestAddOrRemoveLines   = "KPLIB_logisticsCO_requestAddOrRemoveLines";

KPLIB_logisticsCO_requestTransportBuild     = "KPLIB_logisticsCO_requestTransportBuild";
KPLIB_logisticsCO_requestTransportRecycle   = "KPLIB_logisticsCO_recycleTransportBuild";

KPLIB_logisticsCO_requestMissionConfirm     = "KPLIB_logisticsCO_requestMissionConfirm";
KPLIB_logisticsCO_requestMissionAbort       = "KPLIB_logisticsCO_requestMissionAbort";

// The individual status flags in which a TRANSPORT CHANGE ORDER request may occur
KPLIB_logisticsCO_status_transportRequestArray = [
    KPLIB_logistics_status_standby
    , KPLIB_logistics_status_loadingUnloading
];

if (isServer) then {
    // Server section (dedicated and player hosted)

    KPLIB_param_logisticsCO_debug                               = false;

    KPLIB_param_logisticsCO_addOrRemoveLinesPeriodSeconds       = 1;
    KPLIB_param_logisticsCO_onRequestAddOrRemoveLines_debug     = false;

    KPLIB_param_logisticsCO_onRequestTransportBuild_debug       = false;
    KPLIB_param_logisticsCO_onRequestTransportRecycle_debug     = false;

    KPLIB_param_logisticsCO_onTransportBuild_debug              = false;
    KPLIB_param_logisticsCO_onTransportBuildEntering_debug      = false;

    KPLIB_param_logisticsCO_onTransportRecycle_debug            = false;
    KPLIB_param_logisticsCO_onTransportRecycleEntering_debug    = false;

    KPLIB_param_logisticsCO_onRequestMissionConfirm_debug       = false;
    KPLIB_param_logisticsCO_onMissionConfirmEntering_debug      = false;
    KPLIB_param_logisticsCO_onMissionConfirm_debug              = false;

    KPLIB_param_logisticsCO_onRequestMissionReroute_debug       = true;
    KPLIB_param_logisticsCO_onMissionRerouteEntering_debug      = true;
    KPLIB_param_logisticsCO_onMissionReroute_debug              = true;

    KPLIB_param_logisticsCO_onRequestMissionAbort_debug         = false;
    KPLIB_param_logisticsCO_onMissionAbortEntering_debug        = false;
    KPLIB_param_logisticsCO_onMissionAbort_debug                = true;

    KPLIB_param_logisticsCO_onMissionBlockedEntering_debug      = true;
    KPLIB_param_logisticsCO_onMissionBlocked_debug              = true;

    KPLIB_param_logisticsCO_onMissionAbandonedEntering_debug    = true;
    KPLIB_param_logisticsCO_onMissionAbandoned_debug            = true;

    KPLIB_param_logisticsCO_onAbortLoading_debug                = true;
    KPLIB_param_logisticsCO_onAbortUnloading_debug              = true;
    KPLIB_param_logisticsCO_onAbortEnRoute_debug                = true;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logisticsCO_onPreInit] Initialized", "PRE] [LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
