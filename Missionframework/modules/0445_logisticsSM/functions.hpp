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

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrOpened' CBA server event handler
    class logisticsSM_onLogisticsMgrOpened {};

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrClosed' CBA server event handler
    class logisticsSM_onLogisticsMgrClosed {};

    // Publishes to the client logistics line tuples converted from 'KPLIB_logistics_namespaces'
    class logisticsSM_onPublishLines {};

    // Broadcasts the logistics lines to all currently registered logistics manager listeners
    class logisticsSM_onBroadcastLines {};

    // Request to either add or remove some UUID to or from the CBA logistic namespaces
    class logisticsSM_onRequestLineChange {};

    // Client requests convoy transport build
    class logisticsSM_onRequestTransportBuild {}

    // Client requests convoy transport recycle
    class logisticsSM_onRequestTransportRecycle {}

    // Server side callback publishes an ENDPOINT array to the specified client
    class logisticsSM_onPublishEndpoints {};

    // Server side callback broadcasts an ENDPOINT array to the specified clients
    class logisticsSM_onBroadcastEndpoints {};

    // Returns the CBA logistics namespaces array
    class logisticsSM_getList {};

    // Clears the publication required flags and resets the broadcast timer 
    class logisticsSM_clearPublicationRequired {};

    // Logistics SM rebasing 'onStateEntered' event handler
    class logisticsSM_onRebasingEntered {};

    // Logistics SM standby 'onState' event handler
    class logisticsSM_onStandby {};
};
