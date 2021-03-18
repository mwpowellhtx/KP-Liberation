/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 12:34:49
    Last Update: 2021-03-18 18:31:25
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
