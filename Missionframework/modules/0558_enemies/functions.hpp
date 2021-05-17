/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-05-17 15:24:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class enemy {
    file = "modules\0558_enemies\fnc";

    // Initialization phase event handler
    class enemies_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class enemies_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class enemies_settings {};

    // Loads module specific data from the save
    class enemies_loadData {};

    // Saves module specific data for the save
    class enemies_saveData {};

    // Add/Remove awareness amount
    class enemies_addAwareness {};

    // Add/Remove strength amount
    class enemies_addStrength {};

    // Strength increase event function
    class enemies_strengthInc {};

    // Adds a delta to CIVILIAN REPUTATION along with optional notification
    class enemies_addCivRep {};

    // Updates the DISPOSITION between factions according to AWARENESS, STRENGTH, CIVILIAN REPUTATION
    class enemies_onUpdateDisposition {};

    // Get valid transport vehicle for given amount of soldiers
    class enemies_getTransportClasses {};

    // Transfer convoy endpoint event handler
    class enemies_onTransferConvoyEnd {};

    // // Send given troops from nearest military base to sector
    // class enemies_reinforceGarrison {};

    // // Handle sector activation
    // class enemies_sectorAct {};

    // // Handle sector capture
    // class enemies_sectorCapture {};

    // // Handle sector deactivation
    // class enemies_sectorDeact {};

    // // Spawns an enemy patrol
    // class enemies_spawnPatrol {};

    // // Transfer given troops from one sector to another
    // class enemies_transferGarrison {};

    // // Returns the enemy THRESHOLD, adaptive depending on AWARENESS, STRENGTH, etc
    // class enemies_getThreshold {};

    // // // TODO: TBD: migrating to a simple CBA config based statemachine
    // // Enemy commander FSM for decision making
    // class enemies_commanderLogic {
    //     ext = ".fsm";
    // };

    // Returns the ratio of ENEMY STRENGTH over MAX STRENGTH
    class enemies_getStrengthRatio {};

    // Returns the ratio of ENEMY AWARENESS over MAX AWARENESS
    class enemies_getAwarenessRatio {};

    // Returns the CIVILIAN REPUTATION bounded by plus and minus MAXIMUM CIVILIAN REPUTATION
    class enemies_getCivRepBounded {};

    // Returns the CIVILIAN REPUTATION expressed in terms of a RATIO
    class enemies_getCivRepRatio {};

    // Returns the CIVILIAN REPUTATION ratio in terms of HOSTILITY
    class enemies_getCivRepHostilityRatio {};

    // SECTOR ACTIVATING event handler
    class enemies_onSectorActivating {};

    // REGISTER the BUILDINGS for each sector when it activates
    class enemies_onRegisterBuildings {};

    // SECTOR CAPTURED event handler assesses ENEMY module BATTLE DAMAGE ASSESSMENT
    class enemies_onSectorCaptured {};

    // SECTOR CAPTURED event handler evaluating BUILDINGS DESTROYED issues
    class enemies_onBuildingsDestroyed {};

    // Returns whether BUILDING DESTRUCTION is allowed
    class enemies_allowBuildingDestruction {};

    // Returns the SECTOR CAPTURE REWARD accordingly
    class enemies_getSectorCaptureReward {};
};
