/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-06-14 16:44:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class res {
    file = "modules\0228_resources\fnc";

    // OBJECT DESERIALIZED event handler
    class resources_onObjectDeserialized {};

    // SERIALIZING OBJECT event handler
    class resources_onSerializingObject {};

    // Initialization phase event handler
    class resources_preInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class resources_postInit {
        postInit = 1;
    };

    // Responds when a RESOURCES object was created
    class resources_onVehicleCreated {};

    //
    class resources_resourceIndexToName {};

    // Returns the matrix of XYZ offset coordinates for use by the caller
    class resources_registerStoragePositions {};

    // Estimates the number of crates necessary to support the volume
    class resources_estimateCrates {};

    // Responds to the INTEL object 'init' event
    class resources_onIntelInit {};

    // Returns the randomized INTEL value for the target object
    class resources_getIntelValue {};

    // GATHER INTEL action menu event handler
    class resources_onGatherIntel {};

    // Returns a created INTEL object
    class resources_createIntel {};

    // Responds to 'KPLIB_vehicle_created' events on client and server sides
    class resources_onIntelCreated {};

    // Adds value to intel resource
    class resources_addIntel {};

    // Perform GC duties on the TARGET INTEL OBJECT
    class resources_onIntelGC {};

    // Event handler responds when INTEL LEVEL settings have changed
    class resources_onIntelLevelChanged {};

    // Displays amount of resources in crate
    class resources_checkCrate {};

    // Creates a resource crate
    class resources_createCrate {};

    // Gets a crate value
    class resources_getCrateValue {};

    // Sets a crate value
    class resources_setCrateValue {};

    // Gets storage attachTo positions
    class resources_getAttachArray {};

    // Returns the attached crates on the storages
    class resources_getAttachedCrates {};

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

    // Server side event handler responding to the 'KPLIB_resources_attachedCratesChanged'
    class resources_onAttachedCratesChanged {};

    // Refreshes the storage containers 'KPLIB_resources_storageValue' attribute
    class resources_onRefreshStorageValues {};

    // Populates the storage container assuming apportioned crate volume and storage value global variable
    class resources_onPopulateStorage {};

    // Sets up INTEL actions for the OBJECT
    class resources_setupIntelActions {};

    // Sets up CRATE actions for the OBJECT
    class resources_setupCrateActions {};

    // // TODO: TBD: ditto other notes, future: consider consolidating 'storage', 'positions' etc
    // Sets up STORAGE or TRANSPORT actions for the OBJECT
    class resources_setupStorageActions {};

    // Sets up TRANSPORT actions for the OBJECT
    class resources_setupTransportActions {};
};
