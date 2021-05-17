/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 12:34:49
    Last Update: 2021-05-17 14:22:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.

    Dependencies:
        linq
        timers
        resources
 */

class production {
    file = "modules\0504_production\fnc";

    // Module pre initialization
    class production_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class production_onPostInit {
        postInit = 1;
    };

    // Returns whether the module should be debugged
    class production_debug {};

    // CBA Settings for this module
    class production_settings {};

    // Setup the player action menu
    class production_setupPlayerMenu {};

    // Loads module specific data from the save
    class production_onLoadData {};

    // Saves module specific data for the save
    class production_onSaveData {};

    // Reconciles a set of '_production' data against the currently known 'KPLIB_sectors_factory'
    class production_onReconcile {};

    // Creates a new tuple given the originating sector '_markerName'
    class production_create {};

    // Verifies that '_this' is in the shape of a production array
    class production_verifyArray {};

    // Verifies that '_this' is in the shape of a CBA production namespace
    class production_verifyNamespace {};

    // Verifies that the given ARRAY can be considered a valid PRODUCTION QUEUE
    class production_verifyQueue {};

    // Converts the given '_this' production array to a CBA production namespace
    class production_arrayToNamespace {};

    // Converts the given '_this' production namespace to a production array
    class production_namespaceToArray {};

    // Returns a default, random, production 'capability'
    class production_getDefaultCapability {};

    // Returns whether the tuple can be considered aligned with the originating '_markerName'
    class production_markerExists {};

    // Passes the '_productionElem' through while rendering the '_markerText' and applying it to the '_markerName' marker
    class production_onRenderMarkerText {};

    // Returns whether a target object is within range of the nearest factory sector, plus optional predicate
    class production_isNearCapturedFactory {};

    // Returns whether there are no factory storage containers near the given marker
    class production_callback_onWithoutStorageContainers {};

    // Returns whether there is not already target production capability at the given marker
    class production_callback_onWithoutCapability {};

    // Predicate used  to identify where PRODUCTION namespaces "are BLUFOR"
    class production_whereNamespaceIsBlufor {};

    // Gets all the CBA PRODUCTION namespaces aligned to the PREDICATE
    class production_getAllNamespaces {};

    // Gets a single CBA PRODUCTION namespace by marker, or locationNull if one could not be found
    class production_getNamespaceByMarker {};
};

class productionSM {
    file = "modules\0504_production\statemachine";

    // Module pre initialization
    class productionSM_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionSM_onPostInit {
        postInit = 1;
    };

    // Indicates to the caller whether to debug
    class productionSM_debug {};

    // Prepares the module settings for use via CBA
    class productionSM_settings {};

    // Creates a PRODUCTION state machine for use throughout the module
    class productionSM_createSM {};

    // Gets the list with every state machine iteration
    class productionSM_onGetList {};

    // Event handler responds when client opens the production manager dialog
    class productionSM_onProductionMgrOpened {};

    // Event handler responsds when client closes the production manager dialog
    class productionSM_onProductionMgrClosed {};

    // No operation placeholder used to debug...
    class productionSM_onNoOp {};

    // CBA PRODUCTION namespace REBASE 'onStateEntered' event handler
    class productionSM_onRebaseEntered {};

    // CBA PRODUCTION namespace PENDING 'onState' event handler
    class productionSM_onStandbyOrPending {};

    // Returns whether the CBA PRODUCTION namespace has a RUNNING TIMER
    class productionSM_hasRunningTimer {};

    // Returns whether the CBA PRODUCTION namespace has an ELAPSED TIMER
    class productionSM_hasElapsedTimer {};

    // CBA PRODUCTION namespace PRODUCTION 'onStateEntered' event handler
    class productionSM_onProductionEntered {};

    // Tries to produce the next resoure in queue
    class productionSM_tryResourceProduction {};

    // CBA PRODUCTION namespace PRODUCTION 'onTransition' event handler
    class productionSM_onStandbyOrPendingTransit {};

    // Gets the LEAD TIME, may return with a PREEMPTIVE LEAD TIME for troubleshooting purposes
    class productionSM_getProductionTimerDuration {};

    // Updates the QUEUE following production one way or another
    class productionSM_onUpdateQueue {};

    // Broadcasts the current PRODUCTION TUPLES to listening managers
    class productionSM_onBroadcast {};

    // Publishes the current PRODUCTION TUPLES to one listening manager
    class productionSM_onPublish {};

    // Returns whether the BROADCAST TIMER has elapsed; automatically resets the timer when it has elapsed
    class productionSM_hasBroadcastTimerElapsed {};
};

class productionCO {
    file = "modules\0504_production\changeOrders";

    // Module pre initialization
    class productionCO_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionCO_onPostInit {
        postInit = 1;
    };

    // Reports whether the caller should debug
    class productionCO_debug {};

    // Client requests ADD CAPABILITY to a target factory sector
    class productionCO_onRequestAddCap {};

    // Closes the loop on the ADD CAPABILITY client request
    class productionCO_onAddCap {};

    // Evaluates whether the ADD CAPABILITY client request may be performed
    class productionCO_onAddCapEntering {};

    // Makes a capability cost out of the elements
    class productionCO_makeCapDebit {};

    // Tries to debit an added capability and responds with a detailed assessment of the results
    class productionCO_tryDebitCap {};

    // Returns an appropriate CAPABILITY notification string table key
    class productionCO_getCapNotificationKey {};

    // Client requests CHANGE QUEUE for the taget factory sector
    class productionCO_onRequestChangeQueue {};

    // Closes the loop on the CHANGE QUEUE client request
    class productionCO_onChangeQueue {};

    // Evaluates whether the CHANGE QUEUE client request may be performed
    class productionCO_onChangeQueueEntering {};
};

class productionMgr {
    file = "modules\0504_production\ui";

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

    // Close button onButtonClick event handler
    class productionMgr_btnClose_onButtonClick {};

    // Allows for instrospection of the currently selected production marker name
    class productionMgr_getSelectedMarkerName {};

    // Allows for introspection of the currently presented production queue
    class productionMgr_getSelectedQueue {};

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

    // Server published the production state, upon request, during normal or requested statemachine updates, etc
    class productionMgr_onProductionStatePublished {};

    // Map control onLoad event handler
    class productionMgr_ctrlMap_onLoad {};

    // Map control onUnload event handler
    class productionMgr_ctrlMap_onUnload {};
};
