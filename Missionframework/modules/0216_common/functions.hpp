/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 11:56:20
    Last Update: 2021-06-14 16:37:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all common utility functions
 */

class common {
    file = "modules\0216_common\fnc";

    // Returns whether caller should debug
    class common_debug {};

    // Renders the ACTION TITLE given options to localize, color, etc
    class common_renderActionTitle {};

    // Adds action to object with correct localized title
    class common_addAction {};

    //
    class common_addPlayerAction {};

    // Returns whether caller should debug
    class common_settings {};

    // Initialization phase event handler
    class common_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class common_onPostInit {
        postInit = 1;
    };

    // Filters an OBJECT given an ASSOCIATIVE ARRAY of options directing how to do so
    class common_filterObject {};

    // Disembarks the CREW in a VEHICLE
    class common_disembarkCrew {};

    // Returns whether the object may be considered a true VEHICLE
    class common_isVehicle {};

    // Event handler when a unit is KILLED
    class common_onKilled {};

    // Returns the minimum deploy range for an FOB
    class common_getMinimumDeployRange {};

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

    // Check current FPS or if they are higher or equal than given number
    class common_fps {};

    // Generate positions in circle
    class common_getCirclePositions {};

    // Converts the index to that sequence of military alphabet names.
    class common_indexToMilitaryAlpha {};

    // Gets path for className icon
    class common_getIcon {};

    // Returns the ALTITUDE DELTA between two OBJECTS or POSITIONS
    class common_getAltitudeDelta {};

    // Returns the MOMENTUM of the TARGET object
    class common_getMomentum {};

    //
    class common_getNearestObjects {};

   /* Returns the nearest marker to the TARGET object; may reference given SECTORMARKERS, default set
    * draws from a combination of KKPLIB_sectors_all, KPLIB_sectors_startbases, and known FOB BUILDINGS. */
   class common_getNearestMarker {};

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

    // Returns the VEHICLE BOUNDING BOX for the CLASS NAME in consideration
    class common_vehicleBoundingBox {};

    // Returns the VEHICLE SAFE RADIUS for the CLASS NAME in consideration
    class common_vehicleSafeRadius {};
};
