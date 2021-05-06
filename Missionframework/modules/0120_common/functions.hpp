/*
    KP LIBERATION COMMON FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 11:56:20
    Last Update: 2021-05-05 23:15:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all common utility functions
*/

class common {
    file = "modules\0120_common\fnc";

    // Initialization phase event handler
    class common_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class common_onPostInit {
        postInit = 1;
    };

    // Returns whether caller should debug
    class common_debug {};

    // Returns whether caller should debug
    class common_settings {};

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

    //
    class common_onGroupCreated {};

    //
    class common_onUnitCreated {};

    // // // TODO: TBD: probable also vic created, eventually...
    // //
    // class common_onVehicleCreated {};

    // Check current FPS or if they are higher or equal than given number
    class common_fps {};

    // Generate positions in circle
    class common_getCirclePositions {};

    // Converts the index to that sequence of military alphabet names.
    class common_indexToMilitaryAlpha {};

    // Gets path for className icon
    class common_getIcon {};

    /* Returns the nearest marker to the target, defaults to include all sectors, start bases and fobs
     * See: KPLIB_sectors_all, KPLIB_sectors_edens, KPLIB_sectors_fobs */
   class common_getNearestMarker {};

    // Returns the nearest FOB marker and UUID to the target. See: KPLIB_sectors_fobs
    class common_getNearestMarkerAndUuid {};

    /* Returns whether the target is within range of the specified sectors.
     * See: KPLIB_sectors_all, KPLIB_sectors_edens, KPLIB_sectors_fobs */
    class common_getTargetMarkerInRange {};

    /* Returns the nearest marker to the target within range of the specified sectors.
     * See: KPLIB_sectors_all, KPLIB_sectors_edens, KPLIB_sectors_fobs */
    class common_getTargetMarkerIfInRange {};

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

    // Returns the calculated radial positions
    class common_calculateRadialPositions {};

    // Returns the NEAREST BUILDINGS which support at least ONE position
    class common_getNearestSpawnBuildings {};

    // Returns the NEAREST SPAWN POSITIONS to the target position
    class common_getNearestSpawnPositions {};

    // Returns whether the CLASS NAME is indeed a CLASS
    class common_isClass {};
};
