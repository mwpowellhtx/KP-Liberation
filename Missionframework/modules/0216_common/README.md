# KP Liberation Module Description

## Common Module
The common module provides vanilla command replacement functions which should always be used in the Liberation environment.
Furthermore it provides functions which are often used and are not specifically connected to one module.

### Dependencies
This module uses no data or functions from other modules.

### Functions

* KPLIB_fnc_common_addAction

  *Adds given action local to given object.*

* KPLIB_fnc_common_cameraCircleTarget

  *Let a camera circle around a given target with given params.*

* KPLIB_fnc_common_clearVehicleCargo

  *Clears vehicle cargo.*

* KPLIB_fnc_common_createCrew

  *Spawns a full crew for given vehicle.*

* KPLIB_fnc_common_createGroup

  *Creates a group of given side with given groupmembers.*

* KPLIB_fnc_common_createUnit

  *Creates a unit with given classname in given group.*

* KPLIB_fnc_common_createVehicle

  *Creates a vehicle at given position with given direction.*

* KPLIB_fnc_common_getCirclePosition

  *Generate positions in circle.*

* KPLIB_fnc_common_getIcon

  *Gets path for className icon.*

* KPLIB_fnc_common_getNearestMarker

  *Returns the nearest sector marker to the &apos;_target&apos;; &apos;_sectors&apos; defaults to ALL, literally, all sectors, including Eden start bases and FOB zones. Additionally, the function is no longer concerned with ranges and simply returns the nearest marker, leaving it to the caller to make such decisions.*

* KPLIB_fnc_common_getPlayerFob

  *Returns the _markerName of the FOB nearest to the player, if possible.*

* KPLIB_fnc_common_getPos

  *getPos wrapper for ATL positions.*

### Scripts
No scripts will be started by this module
