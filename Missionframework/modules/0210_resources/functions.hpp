/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-02-21 20:34:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class res {
    file = "modules\0210_resources\fnc";

    // Adds actions to spawned crates
    class resources_addActions {};

    //
    class resources_resourceIndexToName {};

    // Estimates the number of crates necessary to support the volume
    class resources_estimateCrates {};

    // Adds value to intel resource
    class resources_addIntel {};

    // Displays amount of resources in crate
    class resources_checkCrate {};

    // Creates a resource crate
    class resources_createCrate {};

    // Gets storage attachTo positions
    class resources_getAttachArray {};

    // Gets Z offset for crate storing
    class resources_getCrateZ {};

    // Gets array with amounts of all resources at given location
    class resources_getResTotal {};

    // Gets array with all storage objects in given radius of given position
    class resources_getStorages {};

    // Gets amount of free storage space of given storage
    class resources_getStorageSpace {};

    // Gets array with resource values of given storage
    class resources_getStorageValue {};

    // Loads crate to transport vehicle
    class resources_loadCrate {};

    // Loads module specific data from the save
    class resources_loadData {};

    // Orders the crates in a storage area
    class resources_orderStorage {};

    // Removes given amount of resources from given location
    class resources_pay {};

    // Module post initialization
    class resources_postInit {
        postInit = 1;
    };

    // Module pre initialization
    class resources_preInit {
        preInit = 1;
    };

    // Push crate
    class resources_pushCrate {};

    // Refunds given amount of resources to the provided location
    class resources_refund {};

    // Saves module specific data for the save
    class resources_saveData {};

    // CBA Settings for this module
    class resources_settings {};

    // Stack and sort crates inside storage area
    class resources_stackNsort {};

    // Store crate in storage
    class resources_storeCrate {};

    // Unloads crate from transport vehicle
    class resources_unloadCrate {};

    // Unstores given kind of resource crate
    class resources_unstoreCrate {};

    // Returns the storage containers in proximity of the specified factory sector
    class resources_getFactoryStorages {};

    // Returns the storage containers in proximity to the specified FOB
    class resources_getFobStorages {};

    // Creates a CBA frame event loop callback to refresh storage
    class resources_createRefreshFactoryStorageValues {};

    // Creates a CBA frame event loop callback to refresh storage
    class resources_createRefreshFobStorageValues {};

    // Refreshes the storage containers 'KPLIB_resources_storageValue' attribute
    class resources_onRefreshStorageValues {};

    // Populates the storage container assuming apportioned crate volume and storage value global variable
    class resources_onPopulateStorage {};
};
