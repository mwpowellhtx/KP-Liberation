/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-28
    Last Update: 2021-05-23 12:32:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class core {
    file = "modules\0224_core\fnc";

    // Client side WAE callback updates the PLAYER PROXIMITY, sector marker name
    class core_onUpdatePlayerProximity {};

    // Initialization phase event handler
    class core_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class core_onPostInit {
        postInit = 1;
    };

    // // // TODO: TBD: refactoring to units module
    // // Check if units are near a position
    // class core_areUnitsNear {};

    // // Change the owner of a sector
    // class core_changeSectorOwner {};

    // Check if win conditions are met
    class core_checkWinCond {};

    // // Creates the Forward Operating Base (FOB) meta-data tuple
    // class core_createFob {};

    // // Selects the Forward Operating Bases (FOBs) meeting the predicated conditions
    // class core_selectFobs {};

    // Get all mobile respawn vehicles
    class core_getMobSpawns {};

    // Get the nearest marker from array of markers
    class core_getNearestMarker {};

    // Handle vehicle spawn event
    class core_handleVehicleSpawn {};

    // Initialize BIS revive
    class core_reviveInit {};

    // CBA Settings for this module
    class core_settings {};

    // The spawn camera sequence
    class core_spawnCam {};

    // Spawning of the Potato 01 helicopter
    class core_spawnPotato {};

    // Spawning of the start vehicles
    class core_spawnStartVeh {};

    // // Updates the sector marker colors
    // class core_updateSectorMarkers {};

    // Returns the player strength as a ratio of connected players to playable slots
    class core_getPlayerStrength {};

    // Returns the COUNT of all GRPS
    class core_getGroupCount {};

    // Returns the NUMBER corresponding to an INDEX RATIO from a set of delimited values
    class core_getIndexedNumber {};
};
