/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-05-06 13:42:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class garrison {
    file = "modules\0330_garrison\fnc";

    // Initialization phase event handler
    class garrison_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class garrison_onPostInit {
        postInit = 1;
    };

    // Loads module specific data from the save
    class garrison_onLoadData {};

    // Saves module specific data for the save
    class garrison_onSaveData {};

    // Prepares the module settings
    class garrison_settings {};

    // // // TODO: TBD: no need to create any GARRISON namespaces
    // // // TODO: TBD: for now we will build on the CBA SECTOR namespace and manage GARRISON variables there
    // // Returns a newly created CBA GARRISON namespace
    // class garrison_createNamespace {};

    // Performs GARRISON specific things during CBA namespace GC
    class garrison_onGC {};

    // Specifies the GARRISON for the CBA SECTOR namespace when necessary
    class garrison_onGarrisoning {};

    // Spawns the INTEL bits during GARRISONING phase
    class garrison_onGarrisoningSpawnIntel {};

    // Spawns the IED bits during GARRISONING phase
    class garrison_onGarrisoningSpawnIeds {};

    // Spawns the RESOURCE bits during GARRISONING phase
    class garrison_onGarrisoningSpawnResources {};

    // // Returns the desired filter approaching the GARRISON spec calculations
    //class garrison_onGarrisoningGetFilter {};

    // // Calculates each count given a set of repeatable parameters, i.e. UNITS, LIGHT VEHICLES, HEAVY VEHICLES, GRPS
    // class garrison_onGarrisoningCalculateEachCount {};

    // // Calculates the GARRISON counts given the specified blue print
    // class garrison_onGarrisoningCalculateCounts {};

    // // Calculates the BITS for use during GARRISON, applies for INTEL for military bases, also IED scenarios
    // class garrison_onGarrisoningCalculateBits {};

    // //
    // class garrison_onGarrisoningMakeIntelArgs {};

    // //
    // class garrison_onGarrisoningMakeIedArgs {};

    // Converts the CBA GARRISON namespace to a serialization consistent TUPLE ARRAY
    class garrison_namespaceToArray {};

    // Converts the serialization consistent TUPLE ARRAY to CBA GARRISON namespace
    class garrison_arrayToNamespace {};

    // Clears the CBA SECTOR namespaces when SIDE(s) changed
    class garrison_onSideChangedClearSectorNamespaces {};

    // Add infantry to sector garrison
    class garrison_addInfantry {};

    // Add light vehicle to sector garrison
    class garrison_addVeh {};

    // Remove given vehicle from sector garrison
    class garrison_delVeh {};

    // Finds empty position suitable for vehicle spawn
    class garrison_getVehSpawnPos {};

    // // Gets the specific CBA GARRISON namespace
    // class garrison_getNamespace {};

    // Gets the specific GARRISON tuple
    class garrison_getGarrison {};

    // // Returns the SECTOR COUNTS
    // class garrison_getSectorCounts {};

    // // Spawns the garrison upon sector activation
    // class garrison_onSpawn {};

    // // Event handler responding to SECTOR ACTIVATED event
    // class garrison_onSectorActivated {};

    // Spawns garrison infantry at a sector
    class garrison_onSpawnSectorInfantry {};

    // Spawns a vehicle at a sector
    class garrison_onSpawnSectorVehicle {};

    // Event handler responding to SECTOR DEACTIVATING event
    class garrison_onSectorDeactivating {};

    // // Event handler responding to SECTOR DEACTIVATED event
    // class garrison_onSectorDeactivated {};

    // // // TODO: TBD: instead consider these bits, and transfer what makes sense into SECTOR module tryDeactivate
    // // Despawns the sector garrison and updates the garrison array with actual data
    // class garrison_onDespawn {};

    // // Event handler responds when SECTOR has been CAPTURED
    // class garrison_onSectorCaptured {};

    //
    class garrison_getLightVehiclePresets {};

    //
    class garrison_getHeavyVehiclePresets {};

    // Returns the BLUFOR SECTOR COUNTS
    class garrison_getBluforSectorCounts {};

    // Returns the OPFOR SECTOR COUNTS
    class garrison_getOpforSectorCounts {};

    //
    class garrison_getOpforGarrison {};

    //
    class garrison_getBluforGarrison {};

    //
    class garrison_getRatioBundle {};
};
