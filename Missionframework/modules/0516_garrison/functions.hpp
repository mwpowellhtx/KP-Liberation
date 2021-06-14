/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-06-14 17:13:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class garrison {
    file = "modules\0516_garrison\fnc";

    // Arranges the module preset variables
    class garrison_presets {};

    // Arranges the module CBA settings
    class garrison_settings {};

    // Module LOAD DATA event handler
    class garrison_onLoadData {};

    // Module SAVE DATA event handler
    class garrison_onSaveData {};

    // Initialization phase event handler
    class garrison_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class garrison_onPostInit {
        postInit = 1;
    };

    // Returns a SAFE POSITION given POS and RANGE inputs
    class garrison_findSafePosition {};

    // Returns the POSITIONS available by zero or more BUILDING objects
    class garrison_getBuildingPositions {};

    // Returns the POSITIONS closely associated with zero or more ROAD objects
    class garrison_getRoadPositions {};

    // Returns the VEHICLE POSITION used when creating the asset resource etc
    class garrison_getVehiclePosition {};

    // Returns whether BUILDING DESTRUCTION is ALLOWED for the sector
    class garrison_allowBuildingDestruction {};

    // Returns whether the sector SHOULD GARRISON APCS with LIGHT VEHICLES
    class garrison_shouldGarrisonApcs {};

    // Returns with an array of OPFOR LIGHT VEHICLE preset classes
    class garrison_getLightVehiclePresets {};

    // Returns with an array of OPFOR HEAVY VEHICLE preset classes
    class garrison_getHeavyVehiclePresets {};

    // Returns a BUNDLE of key OPFOR+BLUFOR+CIVILIAN ratios informing REGIMENT event handlers
    class garrison_getRatioBundle {};

    //
    class garrison_onSectorActivating {};

    // 'KPLIB_sectors_garrison' event handler, delegates for either OPFOR|BLUFOR alignment
    class garrison_onSectorGarrison {};

    // 'KPLIB_sectors_regiment' event handler, delegates for either OPFOR|BLUFOR alignment
    class garrison_onSectorRegiment {};

    // Tears down the garrisoned objects following SECTOR deactivation
    class garrison_onSectorTearDown {};

    // Catalogs POSITION supporting BUILDINGS during the GARRISON event handling phase
    class garrison_onCatalogBuildings {};

    // Catalogs the ROADS during the GARRISON event handling phase
    class garrison_onCatalogRoads {};

    // Allocates for RESOURCES regimentation during the REGIMENT event handling phase
    class garrison_onAllocateResources {};

    // Allocates for MINE (IED) regimentation during the REGIMENT event handling phase
    class garrison_onAllocateMines {};

    // Allocates for OPFOR INTEL regimentation during the REGIMENT event handling phase
    class garrison_onAllocateOpforIntel {};

    // Allocates for OPFOR GRPS regimentation during the REGIMENT event handling phase
    class garrison_onAllocateOpforGrps {};

    // Allocates for OPFOR UNIT regimentation during the REGIMENT event handling phase
    class garrison_onAllocateOpforUnits {};

    // Allocates for OPFOR LIGHT VEHICLES regimentation during the REGIMENT event handling phase
    class garrison_onAllocateOpforLightVehicles {};

    // Allocates for OPFOR HEAVY VEHICLES regimentation during the REGIMENT event handling phase
    class garrison_onAllocateOpforHeavyVehicles {};

    // Arranges for perennial OPFOR REGIMENT classes
    class garrison_onRegimentOpforPeren {};

    // Arranges for annual OPFOR REGIMENT classes
    class garrison_onRegimentOpforAnnum {};

    //
    class garrison_onRegimentOpforUnits {};

    // Arranges for BLUFOR REGIMENT UNIT classes
    class garrison_onRegimentBluforUnits {};

    // Arranges for BLUFOR REGIMENT LIGHT VEHICLE classes
    class garrison_onRegimentBluforLightVehicles {};

    // Arranges for BLUFOR REGIMENT HEAVY VEHICLE classes
    class garrison_onRegimentBluforHeavyVehicles {};

    // Creates RESOURCE objects during the GARRISON event handling phase
    class garrison_onCreateResources {};

    // Creates MINE (IED) objects during the GARRISON event handling phase
    class garrison_onCreateMines {};

    // Creates OPFOR INTEL during the GARRISON event handling phase
    class garrison_onCreateOpforIntel {};

    // Creates OPFOR UNITS during the GARRISON event handling phase
    class garrison_onCreateOpforUnits {};

    // Creates OPFOR ASSETS during the GARRISON event handling phase
    class garrison_onCreateOpforAssets {};

    // Creates BLUFOR UNITS during the GARRISON event handling phase
    class garrison_onCreateBluforUnits {};

    // Creates BLUFOR ASSETS during the GARRISON event handling phase
    class garrison_onCreateBluforAssets {};
};

// TODO: TBD: rename garrison UI to garrisonMgr, etc...
// TODO: TBD: will focus on this following captive refactoring...
class garrisonUI {
    file = "modules\0516_garrison\ui";

    //
    class garrisonUI_settings {};

    //
    class garrisonUI_setupPermissions {};

    //
    class garrisonUI_setupPlayerActions {};

    // Initialization phase event handler
    class garrisonUI_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class garrisonUI_onPostInit {
        postInit = 1;
    };
};
