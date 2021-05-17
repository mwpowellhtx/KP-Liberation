#include "defines.hpp"
/*
    KPLIB_fnc_logisticsMgr_onPreInit

    File: fn_logisticsMgr_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-03-15 01:17:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/set
        https://community.bistudio.com/wiki/createHashMap
        https://community.bistudio.com/wiki/CfgMarkers
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
        https://www.w3schools.com/colors/colors_picker.asp
 */

if (isServer) then {
    ["[fn_logisticsMgr_onPreInit] Initializing...", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

KPLIB_logisticsMgr_onEndpointsPublished                 = "KPLIB_logisticsMgr_onEndpointsPublished";

[] call KPLIB_fnc_logisticsMgr_settings;

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section

    KPLIB_param_logisticsMgr_enableOrDisablePeriod      = 1;

    KPLIB_logisticsMgr_markerName                       = "KPLIB_logisticsMgr_pos";
    KPLIB_logisticsMgr_actualMarkerName                 = "KPLIB_logisticsMgr_actualPos";
    KPLIB_logisticsMgr_loadingClassName                 = "hd_start";
    KPLIB_logisticsMgr_unloadingClassName               = "hd_end";
    KPLIB_logisticsMgr_enRouteClassName                 = "hd_arrow";
    KPLIB_logisticsMgr_ambushedClassName                = "hd_ambush";
    KPLIB_logisticsMgr_routeBlockedClassName            = "hd_objective";

    // Defined in layout order from top-left to bottom-right...
    KPLIB_logisticsMgr_ctrls_mayRemoveLine = [
        KPLIB_IDC_LOGISTICSMGR_BTN_LINE_REMOVE
    ];
    KPLIB_logisticsMgr_ctrls_mayManageConvoyTransports  = [
        KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_BUILD
        , KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_RECYCLE
    ];
    KPLIB_logisticsMgr_ctrls_mayBuildConvoyTransports   = [
        KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_BUILD
    ];
    KPLIB_logisticsMgr_ctrls_mayRecycleConvoyTransports = [
        KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_RECYCLE
    ];
    KPLIB_logistics_ctrls_endpointGrps                  = [
        KPLIB_IDC_LOGISTICSMGR_ALPHA_GRP
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_GRP
    ];
    KPLIB_logisticsMgr_ctrls_mayConfigureAlpha          = [
        KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_SUPPLY
        , KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_AMMO
        , KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_FUEL
    ];
    KPLIB_logisticsMgr_ctrls_mayConfigureBravo          = [
        KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_SUPPLY
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_AMMO
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_FUEL
    ];
    KPLIB_logisticsMgr_ctrls_mayConfigureBills          = [
        KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_SUPPLY
        , KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_AMMO
        , KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_FUEL
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_SUPPLY
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_AMMO
        , KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_FUEL
    ];
    KPLIB_logisticsMgr_ctrls_mayConfirm                 = [
        KPLIB_IDC_LOGISTICSMGR_BTN_MISSION_CONFIRM
    ];
    KPLIB_logisticsMgr_ctrls_mayReroute                 = [
        KPLIB_IDC_LOGISTICSMGR_BTN_MISSION_REROUTE
    ];
    KPLIB_logisticsMgr_ctrls_mayAbort                   = [
        KPLIB_IDC_LOGISTICSMGR_BTN_MISSION_ABORT
    ];

    KPLIB_logistics_telemetry_hashMap_status            = "_status";
    KPLIB_logistics_telemetry_hashMap_estimatedDistance = "_estimatedDistance";
    KPLIB_logistics_telemetry_hashMap_estimatedDuration = "_estimatedDuration";
    KPLIB_logistics_telemetry_hashMap_duration          = "_duration";
    KPLIB_logistics_telemetry_hashMap_elapsedTime       = "_elapsedTime";
    KPLIB_logistics_telemetry_hashMap_timeRemaining     = "_timeRemaining";
    KPLIB_logistics_telemetry_hashMap_transportSpeed    = "_transportSpeed";

    KPLIB_logisticsMgr_cboEndpointHashMap               = [] call {
        private _retval = createHashMap;
        _retval set ["ALPHA", "KPLIB_logisticsMgr_cboAlpha"];
        _retval set ["BRAVO", "KPLIB_logisticsMgr_cboBravo"];
        _retval;
    };

    // TODO: TBD: there are no doubt FAR better ways to handle this...
    KPLIB_logisticsMgr_edtEndpointHashMap               = [] call {
        private _retval = createHashMap;

        // Aligning the ENDPOINT with the RESOURCE in order to obtain a namespace resource key
        _retval set [["ALPHA", 0], "KPLIB_logisticsMgr_edtAlphaSupply"];
        _retval set [["ALPHA", 1], "KPLIB_logisticsMgr_edtAlphaAmmo"];
        _retval set [["ALPHA", 2], "KPLIB_logisticsMgr_edtAlphaFuel"];

        _retval set [["BRAVO", 0], "KPLIB_logisticsMgr_edtBravoSupply"];
        _retval set [["BRAVO", 1], "KPLIB_logisticsMgr_edtBravoAmmo"];
        _retval set [["BRAVO", 2], "KPLIB_logisticsMgr_edtBravoFuel"];

        _retval;
    };
};

if (isServer) then {
    ["[fn_logisticsMgr_onPreInit] Initialized", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
