/*
    KPLIB_fnc_logisticsMgr_settings

    File: fn_logisticsMgr_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-05-17 17:18:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Arranges the module settings.

    Parameters:
        NONE

    Returns:
        NONE
 */

[
    "KPLIB_param_logisticsMgr_debug"
    , "CHECKBOX"
    , [localize "STR_KPLIB_SETTINGS_LOGISTICSMGR_DEBUG", localize "STR_KPLIB_SETTINGS_LOGISTICSMGR_DEBUG_TT"]
    , localize "STR_KPLIB_SETTINGS_DEBUG"
    , false // default: false
    , 0
    , {}
] call CBA_Settings_fnc_init;

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
KPLIB_param_logisticsMgr_lnbTelemetry_getReport_debug       = false;
KPLIB_param_logisticsMgr_lnbTelemetry_onUpdateReport_debug  = false;
KPLIB_logisticsMgr_lnbTelemetry_onLoad_debug                = false;
KPLIB_logisticsMgr_lnbTelemetry_onClear_debug               = false;
KPLIB_param_logisticsMgr_lnbTelemetry_onRefresh_debug       = false;
KPLIB_logisticsMgr_btnRefresh_onButtonClick_debug           = false;
KPLIB_logisticsMgr_cboEndpoint_onLoad_debug                 = false;
KPLIB_logisticsMgr_cboEndpoint_onReload_debug               = false;
KPLIB_logisticsMgr_cboEndpoint_getSelectedEndpoint_debug    = false;
KPLIB_logisticsMgr_cboEndpoint_onLBSelChanged_debug         = false;
KPLIB_logisticsMgr_cboEndpoint_onSetFocus_debug             = false;
KPLIB_param_logisticsMgr_cboEndpoint_setViewData_debug      = false;
KPLIB_param_logisticsMgr_cboEndpoints_getViewData_debug     = false;
KPLIB_param_logisticsMgr_ctrlMap_onReload_debug             = false;
KPLIB_logisticsMgr_onLinesPublished_debug                   = false;
KPLIB_param_logisticsMgr_onEndpointsPublished_debug         = false;
KPLIB_logisticsMgr_onEnableOrDisableCtrls_debug             = false;
KPLIB_logisticsMgr_calculateToEnableOrDisable_debug         = false;
KPLIB_logisticsMgr_onUnload_debug                           = false;

true;
