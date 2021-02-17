/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 12:34:49
    Last Update: 2021-02-17 12:23:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.

    Dependencies:
        0015_linq
        0025_timers
        0210_resources
*/

class production {
    file = "modules\0410_production\fnc";

    // Module pre initialization
    class production_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class production_onPostInit {
        postInit = 1;
    };

    // Creates a new tuple given the originating sector '_markerName'
    class production_create {};

    // Returns a default, random, production 'capability'
    class production_getDefaultCapability {};

    // Returns whether the tuple can be considered aligned with the originating '_markerName'
    class production_markerExists {};

    // Returns whether the module should be debugged
    class production_debug {};

    // Loads module specific data from the save
    class production_onLoadData {};

    // Saves module specific data for the save
    class production_onSaveData {};

    // Reconciles a set of '_production' data against the currently known 'KPLIB_sectors_factory'
    class production_onReconcile {};

    // Passes the '_productionElem' through while rendering the '_markerText' and applying it to the '_markerName' marker
    class production_onRenderMarkerText {};

    // CBA Settings for this module
    class production_settings {};

    // Setup the player action menu
    class production_setupPlayerMenu {};

    // Returns whether a target object is within range of the nearest factory sector, plus optional predicate
    class production_isNearCapturedFactory {};

    // Returns whether there are no factory storage containers near the given marker
    class production_callback_onWithoutStorageContainers {};

    // Returns whether there is not already target production capability at the given marker
    class production_callback_onWithoutCapability {};

    // Handles the debit phase of adding capability to the sector
    class production_onDebitCapability {};

    // CBA 'KPLIB_production_onAddCapability' server event handler
    class productionServer_onAddCapability {};

    // Verifies that '_this' is in the shape of a production array
    class production_verifyArray {};

    // Verifies that '_this' is in the shape of a CBA production namespace
    class production_verifyNamespace {};

    // Converts the given '_this' production array to a CBA production namespace
    class production_arrayToNamespace {};

    // Converts the given '_this' production namespace to a production array
    class production_namespaceToArray {};

    // Creates the production CBA statemachine
    class production_onCreateStatemachine {};

    // CBA 'KPLIB_productionServer_onRequestProduction' server event handler
    class productionServer_onRequestProduction {};

    // Server client report of the '_productionElem' to registered client owners
    class productionServer_onOwnerProductionElem {};

    // CBA 'KPLIB_productionServer_onRequestQueueChange' server event handler
    class productionServer_onRequestQueueChange {};
};
