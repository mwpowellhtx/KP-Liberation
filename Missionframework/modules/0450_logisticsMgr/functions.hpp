/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:55:07
    Last Update: 2021-02-25 13:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logisticsMgr {
    file = "modules\0450_logisticsMgr\fnc";

    // Returns whether caller should conduct debugging
    class logisticsMgr_debug {};

    // Module post initialization phase event handler
    class logisticsMgr_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsMgr_onPreInit {
        preInit = 1;
    };

    // Initializes module CBA settings
    class logisticsMgr_settings {};

    // Setup player menu
    class logisticsMgr_setupPlayerMenu {};

    // Opens the logistics manager dialog
    class logisticsMgr_openDialog {};

    // Dialog 'onLoad' event handler
    class logisticsMgr_onLoad {};

    // Dialog 'onUnload' event handler
    class logisticsMgr_onUnload {};

    // Lines LISTNBOX 'onLoad' event handler
    class logisticsMgr_lnbLines_onLoad {};

    // Lines LISTNBOX reload callback
    class logisticsMgr_lnbLines_onReload {};

    // Lines LISTNBOX 'onLoad' dummy data event handler
    class logisticsMgr_lnbLines_onLoadDummyData {};

    // Lines LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbLines_onLBSelChanged {};

    // Line Add CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnLineAdd_onButtonClick {};

    // Line Remove CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnLineRemove_onButtonClick {};

    // Refresh CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnRefresh_onButtonClick {};

    // 'KPLIB_logisticsMgr_onLinesPublished' CBA event handler
    class logisticsMgr_onLinesPublished {};

    // Gets the TELEMETRY REPORT HASHMAP from the 'uiNamespace', creating one if necessary
    class logisticsMgr_lnbTelemetry_getReport {};

    // Updates the TELEMETRY HASHMAP report given nominal arguments
    class logisticsMgr_lnbTelemetry_onUpdateReport {};

    // Refreshes the TELEMETRY LISTNBOX with the current REPORT HASHMAP bits
    class logisticsMgr_lnbTelemetry_onRefresh {};

    // Clears the TELEMETRY LISTNBOX and prepares it to receive HASHMAP reports
    class logisticsMgr_lnbTelemetry_onClear {};

    // Responds to the TELEMETRY LISTNBOX 'onLoad' event by clearing and staging the bits for subsequent use
    class logisticsMgr_lnbTelemetry_onLoad {};

    // Telemetry LISTNBOX 'onLoad' dummy data event handler
    class logisticsMgr_lnbTelemetry_onLoadDummyData {};

    // Telemetry LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbTelemetry_onLBSelChanged {};

    // Clears the Convoy LISTNBOX during 'onLoad' and prepares it to receive transport value
    class logisticsMgr_lnbConvoy_onClear {};

    // Convoy LISTNBOX 'onLoad' event handler
    class logisticsMgr_lnbConvoy_onLoad {};

    // Convoy LISTNBOX reload callback, typically seen during 'onLoad', also when LINES LISTNBOX selection changes
    class logisticsMgr_lnbConvoy_onReload {};

    // Convoy LISTNBOX 'onLoad' dummy data event handler
    class logisticsMgr_lnbConvoy_onLoadDummyData {};

    // Convoy LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbConvoy_onLBSelChanged {};

    // Add and Recycle Transport CT_BUTTON 'onButtonClick' event handlers
    class logisticsMgr_btnTransportRequest_onButtonClick {};

    // Endpoint CT_COMBO 'onLoad' event handler
    class logisticsMgr_cboEndpoint_onLoad {};

    // Endpoint CT_COMBO 'onLoad' dummy data event handler
    class logisticsMgr_cboEndpoint_onLoadDummyData {};

    // Resource CT_EDIT 'onKeyUp' event handler
    class logisticsMgr_edtResource_onKeyUp {};

    // Resource CT_EDIT 'onChar' event handler
    class logisticsMgr_edtResource_onChar {};

    // Resource CT_EDIT 'onKillFocus' event handler
    class logisticsMgr_edtResource_onKillFocus {};

    // Confirm mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnConfirm_onButtonClick {};

    // Abort mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnAbort_onButtonClick {};

    // Transforms the logistics line tuple to a view for use with the LINES LISTNBOX
    class logisticsMgr_toLineView {};
};
