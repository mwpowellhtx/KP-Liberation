/*
    KP LIBERATION CORE FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-28
    Last Update: 2021-05-05 14:10:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class core {
    file = "modules\0224_core\fnc";

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

    // // Build fob and register it
    // class core_buildFob {};

    // Build fob at random position and register it
    class core_buildFobRandom {};

    // Checks if player can build fob
    class core_canBuildFob {};

    // Check if win conditions are met
    class core_checkWinCond {};

    // Creates the Forward Operating Base (FOB) meta-data tuple
    class core_createFob {};

    // Selects the Forward Operating Bases (FOBs) meeting the predicated conditions
    class core_selectFobs {};

    // Repackages the nearest FOB to either container or truck depending on the event arguments
    class core_onRepackageFob {};

    // Confirmes repackaging of an FOB
    class core_onConfirmRepackageFob {};

    // Repackage FOB requested
    class core_onRepackageFobRequested {};

    // Callback used to determine whether the target is within range of the FOB position
    class core_fob_callback_onWithinRange {};

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

    // Setup of actions avaible to players
    class core_setupPlayerActions {};

    // The spawn camera sequence
    class core_spawnCam {};

    // Spawning of the Potato 01 helicopter
    class core_spawnPotato {};

    // Spawning of the start fob box
    class core_spawnStartFobBox {};

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
