/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 09:57:57
    Last Update: 2021-02-06 09:58:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class productionMgr {
    file = "modules\0415_productionMgr\fnc";

    class productionMgr_debug {};

    // Module pre initialization
    class productionMgr_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionMgr_onPostInit {
        postInit = 1;
    };

    // Opens the module dialog
    class productionMgr_openDialog {};

    // Setup the player action menu
    class productionMgr_setupPlayerMenu {};

    // Module display onLoad event handler
    class productionMgr_onLoad {};

    // Module display onUnload event handler
    class productionMgr_onUnload {};

    //// TODO: TBD: refactoring these bits to proper client/server callbacks...
    //// Sectors list box onLoad event handler
    //class productionMgr_lnbSectors_onLoad {};

    // Sectors list box onLoad event handler
    class productionMgr_lnbSectors_onLoad {};

    // Sectors list box onLBSelChanged event handler
    class productionMgr_lnbSectors_onLBSelChanged {};

    // Status list box onLoad event handler
    class productionMgr_lnbStatus_onLoad {};

    // Status list box onLBSelChanged event handler
    class productionMgr_lnbStatus_onLBSelChanged {};

    // Status list box onLBDblClick event handler
    class productionMgr_lnbStatus_onLBDblClick {};

    // Queue list box onLoad event handler
    class productionMgr_lnbQueue_onLoad {};

    // Queue list box onLBSelChanged event handler
    class productionMgr_lnbQueue_onLBSelChanged {};

    // Queue list box onLBDblClick event handler
    class productionMgr_lnbQueue_onLBDblClick {};

    // Loads the time remaining text
    class productionMgr_txtTimeRem_onLoad {};

    // Enqueue resource onButtonClick event handler
    class productionMgr_btnEnqueue_onButtonClick {};

    // Dequeue resource onButtonClick event handler
    class productionMgr_btnDequeue_onButtonClick {};

    // Change queue priority onButtonClick event handler
    class productionMgr_btnChangePriority_onButtonClick {};

    // Refresh button onButtonClick event handler
    class productionMgr_btnRefresh_onButtonClick {};

    // Apply button onButtonClick event handler
    class productionMgr_btnApply_onButtonClick {};

    // Close button onButtonClick event handler
    class productionMgr_btnClose_onButtonClick {};

    // Allows for instrospection of the currently selected production marker name
    class productionMgr_getSelectedMarkerName {};

    // Allows for introspection of the production manager currently selected production tuple
    class productionMgr_getProductionElement {};

    // Sets additional data or value for the specified CT_LISTNBOX and '_rowIndex'
    class productionMgr_setAdditionalDataOrValue {};

    // Gets additional data or value for the specified CT_LISTNBOX and '_rowIndex'
    class productionMgr_getAdditionalDataOrValue {};

    // Arranges the production element view
    class productionMgr_productionElemViews_onSector {};

    // Arranges the production element view
    class productionMgr_productionElemViews_onStatus {};

    // Arranges the production element view
    class productionMgr_productionElemViews_onQueue {};

    // Arranges the production element view
    class productionMgr_productionElemViews_onTimeRem {};

    // Client server request production event handler
    class productionMgr_server_onRequestProduction {};

    // Client server queue change request event handler
    class productionMgr_server_onRequestQueueChange {};

    // Client server production response event handler
    class productionMgr_client_onProductionResponse {};

    // Client server queue change request event handler
    class productionMgr_client_onQueueChangeResponse {};
};
