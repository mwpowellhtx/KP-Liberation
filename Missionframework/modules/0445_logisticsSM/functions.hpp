/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:55:07
    Last Update: 2021-02-28 16:51:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

/*
 TODO: TBD: with the refactory to proper change orders, could be interesting... any operation
 that has an effect on a target namespace might be considered a change order of sorts... so
 potentially we stage those accordingly as such... that could be very interesting...
 */

class logisticsSM {
    file = "modules\0445_logisticsSM\fnc";

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
