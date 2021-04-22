#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSpawnSectorVehicle

    File: fn_garrison_onSpawnSectorVehicle.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-21
    Last Update: 2021-04-14 23:03:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Spawns a vehicle with full crew of given side at given sector.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, default: ""]
        _classname - a classname of the vehicle to spawn [STRING, default: ""]
        _side - a side of the vehicle [SIDE, default: KPLIB_preset_sideE]
        _kind - the kind of the vehicle ('light'|'heavy') [STRING, default: 'light']

    Returns:
        Spawned vehicle [OBJECT]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/ai/fnc_taskPatrol-sqf.html
 */

// TODO: TBD: so... we actually use 'side' here, so why not in the other areas?
params [
    [Q(_markerName), "", [""]]
    , [Q(_classname), "", [""]]
    , [Q(_side), KPLIB_preset_sideE, [sideEmpty]]
    , [Q(_kind), Q(light), [""]]
];

private _vehicle = objNull;

// Exit if no or invalid sector or classname was given
if (_markerName isEqualTo "" || _classname isEqualTo "" || !(_markerName in KPLIB_sectors_all)) exitWith {
    _vehicle;
};

private _actRange = KPLIB_param_sectors_actRange;
private _waypointCompletionRange = MPARAM(_waypointCompletionRange);
private _patrolChance = PCT(MPARAM(_patrolChance));
private _waypointCount = MPARAM(_waypointCount);

// Initialize local variables
private _markerPos = markerPos _markerName;
private _spawnPos = [_markerPos] call MFUNC(_getVehSpawnPos);
private _activeGarrisonRef = [_markerName, true] call MFUNC(_getGarrison);

// Spawn vehicle
_vehicle = [_classname, _spawnPos, random 360, true, true] call KPLIB_fnc_common_createVehicle;
// TODO: TBD: which set damage should perhaps be done by the 'KPLIB_fnc_common_createVehicle' function
_vehicle setDamage 0;
private _crew = crew _vehicle;

// // TODO: TBD: !DEBUG! Add group to Zeus
// {
//     _x addCuratorEditableObjects [[_vehicle], true]
// } forEach allCurators;

// // TODO: TBD: I could be persuaded to adopt a server only AI mod...
// !NOTE!
//     Adding a patrol waypoint pattern to the vehicle let it move like the infantry squads, which is the same like in the old framework.
//     Unfortunately this leads to the behaviour that they can get stuck and drive over their homies with no regrets.
//     So we could let them spawn standing still and just "scan the area" or we keep it like in the old framework and let them drive around.
//     Personally I think both options aren't the best in their current implementation, but I would prefer them to just stand.

// // TODO: TBD: huh? also CBA tasking...
// Add patrol waypoints with a chance otherwise create a waypoint at spawn position
if (random 1 <= _patrolChance) then {
    [_vehicle, _markerPos, _actRange, _waypointCount, "SAD", "SAFE", "RED", "LIMITED"] call CBA_fnc_taskPatrol;
} else {
    private _waypoint = (group (_crew#0)) addWaypoint [_spawnPos, 1];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointCombatMode "RED";
    _waypoint setWaypointSpeed "LIMITED";
    _waypoint setWaypointCompletionRadius _waypointCompletionRange;
};

// Add vehicle and crew to active garrison array
if (_kind isEqualTo Q(light)) then {
    (_activeGarrisonRef#3) pushBack _vehicle;
} else {
    (_activeGarrisonRef#4) pushBack _vehicle;
};

(_activeGarrisonRef#5) append _crew;

// Return vehicle object
_vehicle;
