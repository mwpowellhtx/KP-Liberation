/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 12:34:49
    Last Update: 2021-02-04 12:34:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.

    Dependencies:
        0015_linq
        0025_timers
        0210_resources
*/

class example {
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
    class production_exists {};

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
};
