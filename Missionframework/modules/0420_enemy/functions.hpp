/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-18 23:44:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class enemy {
    file = "modules\0420_enemy\fnc";

    // Initialization phase event handler
    class enemy_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class enemy_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class enemy_settings {};

    // Loads module specific data from the save
    class enemy_loadData {};

    // Saves module specific data for the save
    class enemy_saveData {};

    // Add/Remove awareness amount
    class enemy_addAwareness {};

    // Add/Remove strength amount
    class enemy_addStrength {};

    // Strength increase event function
    class enemy_strengthInc {};

    // Updates the DISPOSITION between factions according to AWARENESS, STRENGTH, CIVILIAN REPUTATION
    class enemy_onUpdateDisposition {};

    // Get valid transport vehicle for given amount of soldiers
    class enemy_getTransportClasses {};

    // Transfer convoy endpoint event handler
    class enemy_onTransferConvoyEnd {};

    // // Send given troops from nearest military base to sector
    // class enemy_reinforceGarrison {};

    // // Handle sector activation
    // class enemy_sectorAct {};

    // // Handle sector capture
    // class enemy_sectorCapture {};

    // // Handle sector deactivation
    // class enemy_sectorDeact {};

    // // Spawns an enemy patrol
    // class enemy_spawnPatrol {};

    // // Transfer given troops from one sector to another
    // class enemy_transferGarrison {};

    // // Returns the enemy THRESHOLD, adaptive depending on AWARENESS, STRENGTH, etc
    // class enemy_getThreshold {};

    // // // TODO: TBD: migrating to a simple CBA config based statemachine
    // // Enemy commander FSM for decision making
    // class enemy_commanderLogic {
    //     ext = ".fsm";
    // };

    // Returns the ratio of ENEMY STRENGTH over MAX STRENGTH
    class enemy_getStrengthRatio {};

    // Returns the ratio of ENEMY AWARENESS over MAX AWARENESS
    class enemy_getAwarenessRatio {};

    // Returns the CIVILIAN REPUTATION bounded by plus and minus MAXIMUM CIVILIAN REPUTATION
    class enemy_getCivRepBounded {};

    // Returns the CIVILIAN REPUTATION in terms of HOSTILITY
    class enemy_getCivRepHostility {};
};
