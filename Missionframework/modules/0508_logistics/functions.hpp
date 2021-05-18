/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:51:36
    Last Update: 2021-05-17 20:34:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logistics {
    file = "modules\0508_logistics\fnc";

    // Returns whether caller should conduct debugging
    class logistics_debug {};

    // Module post initialization phase event handler
    class logistics_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logistics_onPreInit {
        preInit = 1;
    };

    // Arranges for the module CBA settings
    class logistics_settings {};

    // Arranges to load the module saved data
    class logistics_onLoadData {};

    // Arranges to save the module data
    class logistics_onSaveData {};

    // Returns the current set of known ENDPOINTS
    class logistics_getEndpoints {};

    // Returns the current set of abandoned ENDPOINTS
    class logistics_getEndpointsAbandoned {};

    // Returns the ENDPOINT that is not the OTHER one, or itself if one could not be identified
    class logistics_getEndpointOrNearest {};

    // Returns the ALPHA+BRAVO ENDPOINTS swapped, i.e. BRAVO+ALPHA
    class logistics_swapEndpoints {};

    // Creates a newly minted logistics tuple (ARRAY)
    class logistics_createArray {};

    // Converts the given ARRAY to CBA logistics namespace
    class logistics_arrayToNamespace {};

    // Converts the given CBA logistics namespace to ARRAY
    class logistics_namespaceToArray {};

    // Verifies that the ARRAY is shaped as a valid endpoint tuple
    class logistics_verifyEndpoint {};

    // Verifies that the ARRAY is shaped as a valid logistics tuple
    class logistics_verifyArray {};

    // Verifies that the CBA namespace has adequate variable support to be considered a logistics namespace
    class logistics_verifyNamespace {};

    // Returns whether the ALPHA and BRAVO endpoints combination is equal in either direction
    class logistics_areEndpointsEqual {};

    // Returns whether the candidate ENDPOINTS are considered UNIQUE given the set of LINES
    class logistics_areEndpointsUnique {};

    // Returns the ENDPOINT indexes given the current set of known ENDPOINTS
    class logistics_getEndpointIndexes {};

    // Returns whether either of the ENDPOINTS can be considered ABANDONED
    class logistics_areEndpointsAbandoned {};

    // Returns the next available transport awaiting either loading or unloading
    class logistics_findNextTransportIndex {};

    // Returns the logistics namespace given a predicate
    class logistics_getNamespaceBy {};

    // Returns the logistics namespace aligned with the given UUID
    class logistics_getNamespaceByUuid {};

    // Returns an enumerated status report composed of human readable decoded status bits
    class logistics_getStatusReport {};

    // Whether ALPHA ENDPOINT bill values has remaining bill value
    class logistics_alphaEndpointHasBillValue {};

    // Whether BRAVO ENDPOINT bill values has remaining bill value
    class logistics_bravoEndpointHasBillValue {};

    // Whether the logistics ALPHA and BRAVO bill values have been fulfilled
    class logistics_hasTransferCompleted {};

    // Calculates transport position and direction vectors from estimated transit distance, based on nearest road elements, etc
    class logistics_getTransportVectors {};

    // Calculates an up to date transport speed in meters per second (mps) using 'KPLIB_param_logistics_transportSpeedKph'
    class logistics_calculateTransportSpeedMps {};

    // Calculates the current telemetry for the logistics asset
    class logistics_calculateTelemetry {};

    // Gets a telemetry array corresponding to the CBA logistics namespace
    class logistics_getTelemetryArray {};

    // Sets the telemetry for the given CBA logistics namespace
    class logistics_setTelemetry {};

    // Calibrates the logistics timer given the most up to date in situ sitrep
    class logistics_calibrateTimer {};

    // Checks the 'KPLIB_logistics_status' is as expected using, in part, 'BIS_fnc_bitflagsCheck'
    class logistics_checkStatus {};

    // Conditionally sets the TARGET bitwise logistics STATUS; supports both TUPLE and LOCATION form factors
    class logistics_setStatus {};

    // Conditionally unsets the TARGET bitwise logistics STATUS; supports both TUPLE and LOCATION form factors
    class logistics_unsetStatus {};

    // Returns whether the TARGET logistics timer has elapsed; supports both TUPLE and LOCATION form factors
    class logistics_timerHasElapsed {};

    // ...
    class logistics_getRefreshedTimer {};

    // Calculates the TRANSIT DURATION in seconds between ALPHA and BRAVO
    class logistics_calculateTransitDuration {};

    // Determins the mid TRANSIT safe zones in terms of TIMER times in seconds
    class logistics_calculateTransitWindow {};

    // Translates 'KPLIB_param_fobs_range' in terms of 'KPLIB_param_logistics_transportSpeedKph', in meters per second
    class logistics_calculateFobRangeSeconds {};

    // Calculates line estimated position in terms of elapsed time and 'KPLIB_param_logistics_transportSpeedKph'
    class logistics_calculateEstimatedPos {};

    // ...
    class logistics_convoyIsFull {};

    // ...
    class logistics_convoyIsEmpty {};

    // Normalizes the ENDPOINT to standard form factor, potentially inclusive of BILL VALUE
    class logistics_normalizeEndpoint {};

    // Normalizes the ENDPOINTS to an [ALPHA, BRAVO] form factor, potentially inclusive of BILL VALUE
    class logistics_normalizeEndpoints {};
};

class logisticsSM {
    file = "modules\0508_logistics\statemachine";

    // Returns whether caller should conduct debugging
    class logisticsSM_debug {};

    // Module post initialization phase event handler
    class logisticsSM_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsSM_onPreInit {
        preInit = 1;
    };

    // Initializes the CBA settings
    class logisticsSM_settings {};

    // Creates the CBA logistics state machine
    class logisticsSM_createSM {};

    // // Performs logistics state machine garbage collection
    // class logisticsSM_gcSM {};

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrOpened' CBA server event handler
    class logisticsSM_onLogisticsMgrOpened {};

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrClosed' CBA server event handler
    class logisticsSM_onLogisticsMgrClosed {};

    // ...
    class logisticsSM_onAddLines {};

    // ...
    class logisticsSM_onRemoveLines {};

    // // ...
    // class logisticsSM_onAddOrRemoveLines {};

    // ...
    class logisticsSM_getLineUuids {};

    // TODO: TBD: also, we may want to reconsider how we identify line mil-al designations...
    // TODO: TBD: i.e. identify them on the server side as such as part of the tuple...
    // TODO: TBD: especially so as to avoid inadvertently tearing at that incorrectly client side...
    // Publishes a single line to the client, major assumption is that a complete set of ordered lines already exists...
    class logisticsSM_onPublishLine {};

    // Publishes to the client logistics line tuples converted from 'KPLIB_logistics_namespaces'
    class logisticsSM_onPublishLines {};

    // Broadcasts the logistics lines to all currently registered logistics manager listeners
    class logisticsSM_onBroadcastLines {};

    // Server side callback publishes an ENDPOINT array to the specified client
    class logisticsSM_onPublishEndpoints {};

    // Server side callback broadcasts an ENDPOINT array to the specified clients
    class logisticsSM_onBroadcastEndpoints {};

    // Event handler responds to the state machine request for its 'list' on every pass
    class logisticsSM_onGetList {};

    //
    class logisticsSM_onNoOp {};

    // ...
    class logisticsSM_onRefreshTimer {};

    // Logistics SM rebasing 'onStateEntered' event handler
    class logisticsSM_onRebasingEntered {};

    //
    class logisticsSM_onStandby {};

    // ...
    class logisticsSM_onPending {};

    // ...
    class logisticsSM_onLoadingEntered {};

    // ...
    class logisticsSM_onEnRouteEntered {};

    // ...
    class logisticsSM_onUnloadingEntered {};

    // ...
    class logisticsSM_onPendingEnRoute {};

    // ...
    class logisticsSM_onPendingLoading {};

    // ...
    class logisticsSM_onPendingUnloading {};

    //
    class logisticsSM_onConfirmReturn {};

    //
    class logisticsSM_onAbortComplete {};

    // ...
    class logisticsSM_getLoadVolumes {};

    // ...
    class logisticsSM_onApplyTransaction {};

    // ...
    class logisticsSM_tryLoadNextTransport {};

    // ...
    class logisticsSM_tryUnloadNextTransport {};
};

class logisticsCO {
    file = "modules\0508_logistics\changeOrders";

    // Module post initialization phase event handler
    class logisticsCO_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsCO_onPreInit {
        preInit = 1;
    };

    // Returns whether the caller should perform debugging
    class logisticsCO_debug {};

    // Arranges for CBA settings exposed to the LOGISTICS CHANGE ORDERS module
    class logisticsCO_settings {};

    // Client requests that the server build a LOGISTIC LINE TRANSPORT
    class logisticsCO_onRequestTransportBuild {};

    // Client requests that the server recycle a LOGISTIC LINE TRANSPORT
    class logisticsCO_onRequestTransportRecycle {};

    // Screens the target LOGISTIC LINE whether the activity may be performed
    class logisticsCO_onTransportBuildEntering {};

    // Performs the activity on the target LOGISTIC LINE
    class logisticsCO_onTransportBuild {};

    // Screens the target LOGISTIC LINE whether the activity may be performed
    class logisticsCO_onTransportRecycleEntering {};

    // Performs the activity on the target LOGISTIC LINE
    class logisticsCO_onTransportRecycle {};

    // Client requests server side confirmation starting the corresponding LOGISTIC LINE given ENDPOINTS
    class logisticsCO_onRequestMissionConfirm {};

    // Client request server side REROUTE in response to LOGISTIC status ABANDONED
    class logisticsCO_onRequestMissionReroute {};

    // Client requests server side LOGISTIC LINE operation be aborted
    class logisticsCO_onRequestMissionAbort {};

    // ...
    class logisticsCO_onMissionConfirmEntering {};

    // ...
    class logisticsCO_onMissionConfirm {};

    // ...
    class logisticsCO_onMissionAbandonedEntering {};

    // ...
    class logisticsCO_onMissionAbandoned {};

    // ...
    class logisticsCO_onMissionRerouteEntering {};

    // ...
    class logisticsCO_onMissionReroute {};

    // ...
    class logisticsCO_onMissionAbortEntering {};

    // ...
    class logisticsCO_onMissionAbort {};

    // ...
    class logisticsCO_onMissionBlockedEntering {};

    // ...
    class logisticsCO_onMissionBlocked {};

    // Handles aborting when the line was 'KPLIB_logistics_status_enRoute'
    class logisticsCO_onAbortEnRoute {};

    // Handles aborting when the line was 'KPLIB_logistics_status_loading'
    class logisticsCO_onAbortLoading {};

    // Handles aborting when the line was 'KPLIB_logistics_status_unloading'
    class logisticsCO_onAbortUnloading {};

    // Request to either add or remove some UUID to or from the CBA logistic namespaces
    class logisticsCO_onRequestAddOrRemoveLines {};
};

class logisticsMgr {
    file = "modules\0508_logistics\ui";

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

    // Endpoint CT_GROUP 'onLoad' event handler
    class logisticsMgr_endpointCtrls_onLoad {};

    // Endpoint CT_GROUP reload callback
    class logisticsMgr_cboEndpoint_setViewData {};

    // Endpoint CT_COMBO 'onLoad' event handler
    class logisticsMgr_cboEndpoint_onLoad {};

    // Reloads the ENDPOINT CT_COMBO given up to date UI namespace variables
    class logisticsMgr_cboEndpoint_onReload {};

    // Lifts the view data from the ENDPOINT CT_COMBO, including DATA backing each row
    class logisticsMgr_cboEndpoints_getViewData {};

    // Returns the ENDPOINT or ABANDONED POSITION corresponding to the selected MARKER NAME
    class logisticsMgr_cboEndpoint_getMarkerPos {};

    // Client callback responds when server publishes ENDPOINT tuples to listening clients
    class logisticsMgr_onEndpointsPublished {};

    // Endpoint CT_COMBO 'onLoad' dummy data event handler
    class logisticsMgr_cboEndpoint_onLoadDummyData {};

    // ...
    class logisticsMgr_cboEndpoint_onSetFocus {};

    // ...
    class logisticsMgr_cboEndpoint_onKillFocus {};

    // ...
    class logisticsMgr_cboEndpoint_onLBSelChanged {};

    // Returns the ENDPOINT tuple corresponding to the selected CT_COMBO row
    class logisticsMgr_cboEndpoint_getSelectedEndpoint {};

    // Resource CT_EDIT 'onKeyUp' event handler
    class logisticsMgr_edtResource_onKeyUp {};

    // Resource CT_EDIT 'onChar' event handler
    class logisticsMgr_edtResource_onChar {};

    // Resource CT_EDIT 'onKillFocus' event handler
    class logisticsMgr_edtResource_onKillFocus {};

    // Confirm mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnConfirm_onButtonClick {};

    // Reroute mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnReroute_onButtonClick {};

    // Abort mission CT_BUTTON 'onButtonClick' event handler
    class logisticsMgr_btnAbort_onButtonClick {};

    // Transforms the logistics line tuple to a view for use with the LINES LISTNBOX
    class logisticsMgr_toLineView {};

    // Map control 'onLoad' event handler
    class logisticsMgr_ctrlMap_onLoad {};

    // ...
    class logisticsMgr_ctrlMap_onReload {};

    // ...
    class logisticsMgr_ctrlMap_onReloadStandby {};

    // ...
    class logisticsMgr_ctrlMap_onReloadEndpoint {};

    // ...
    class logisticsMgr_ctrlMap_onReloadLoading {};

    // ...
    class logisticsMgr_ctrlMap_onReloadEnRoute {};

    // ...
    class logisticsMgr_ctrlMap_onReloadUnloading {};

    // ...
    class logisticsMgr_onCalculateEstimatedDuration {};

    // ...
    class logisticsMgr_calculateToEnableOrDisable {};
};
