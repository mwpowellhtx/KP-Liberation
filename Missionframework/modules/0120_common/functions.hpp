/*
    KP LIBERATION COMMON FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-15
    Last Update: 2019-06-08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all common utility functions
*/

class common {
    file = "modules\0120_common\fnc";

    // Adds action to object with correct localized title
    class common_addAction {};

    // Let a camera circle around a given target with given params
    class common_cameraCircleTarget {};

    // Do a camera fly by from-to position
    class common_cameraFlyBy {};

    // Clears vehicle cargo
    class common_clearVehicleCargo {};

    // Spawns a full crew for given vehicle
    class common_createCrew {};

    // Creates a group of given side with given groupmembers
    class common_createGroup {};

    // Creates a unit with given classname in given group
    class common_createUnit {};

    // Creates a vehicle at given position with given direction
    class common_createVehicle {};

    // Check current FPS or if they are higher or equal than given number
    class common_fps {};

    // Generate positions in circle
    class common_getCirclePositions {};

    // Converts the index to that sequence of military alphabet names.
    class common_indexToMilitaryAlpha {};

    // Gets path for className icon
    class common_getIcon {};

    // Returns the full [_sectorInfo] tuple from the _target object, if possible [default: ["", "", KPLIB_sectorType_nil]]
    //                                                                         _markerType: ^^
    //                                                                               _uuid:     ^^
    //                                                                         _sectorType:         ^^^^^^^^^^^^^^^^^^^^
   class common_getSectorInfo {};

    // TODO: TBD: note, that we try to maintain some consistency, for now...
    // TODO: TBD: the machinery, best term for it, facilitating the whole build procedure really is massive
    // TODO: TBD: so trying to keep consistency there, for now, before mucking around too much with it

    /* A more specific version, wrapper to 'common_getSectorInfo', does the same thing,
     * filters for the '_markerType', in keeping with the refactor baseline. */
    class common_getPlayerFob {};

    // getPos wrapper for ATL positions
    class common_getPos {};

    // Gets random class of given type from preset
    class common_getPresetClass {};

    // Gets a random spawn marker
    class common_getRandomSpawnMarker {};

    // Gets array of soldier classnames from preset
    class common_getSoldierArray {};

    // Checks if player occupies a slot
    class common_isSlot {};

    // Initialize common module
    class common_preInit {
        preInit = 1;
    };
};
