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

    // Lines LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbLines_onLBSelChanged {};

    // Line Add CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnLineAdd_onButtonClick {};

    // Line Remove CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnLineRemove_onButtonClick {};

    // Refresh CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnRefresh_onButtonClick {};

    // Telemetry LISTNBOX 'onLoad' event handler
    class logisticsMgr_lnbTelemetry_onLoad {};

    // Telemetry LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbTelemetry_onLBSelChanged {};

    // Convoy LISTNBOX 'onLoad' event handler
    class logisticsMgr_lnbConvoy_onLoad {};

    // Convoy LISTNBOX 'onLBSelChanged' event handler
    class logisticsMgr_lnbConvoy_onLBSelChanged {};

    // Add Transport CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnTransportAdd_onButtonClick {};

    // Recycle Transport CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnTransportRecycle_onButtonClick {};

    // Endpoint CT_COMBO 'onLoad' event handler
    class logisticsMgr_cboEndpoint_onLoad {};

    // Resource CT_EDIT 'onKillFocus' event handler
    class logisticsMgr_edtResource_onKillFocus {};

    // Confirm mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnConfirm_onButtonClick {};

    // Abort mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnAbort_onButtonClick {};
};
