#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSpawnSectorInfantry

    File: fn_garrison_onSpawnSectorInfantry.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-20
    Last Update: 2021-04-14 23:02:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Spawns an infantry squad with given amount of soldiers of given side at given sector.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, default: ""]
        _ownerNumber - owner number of the sector [NUMBER, default: 0]
        _count - number of soldiers to spawn [NUMBER, default: 6]

    Returns:
        Spawned infantry squad [GROUP]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/ai/fnc_taskDefend-sqf.html
 */

// TODO: TBD: owner number of the sector...
// TODO: TBD: again, why not simply 'side' (?)
params [
    [Q(_markerName), "", [""]]
    , [Q(_ownerNumber), 0, [0]]
    , [Q(_count), MPARAM(_defaultInfantryCount), [0]]
];

[
    grpNull
    , KPLIB_param_sectors_capRange
    , MPARAM(_defendThreshold)
    , PCT(MPARAM(_defendPatrolChance))
    , PCT(MPARAM(_defendHoldChance))
] params [
    Q(_grp)
    , Q(_capRange)
    , Q(_defendThreshold)
    , Q(_defendPatrolChance)
    , Q(_defendHoldChance)
];

// Exit if no or invalid sector was given
if (!(_markerName in KPLIB_sectors_all)) exitWith {
    _grp;
};

// Initialize local variables
private _markerPos = markerPos _markerName;
private _spawnPos = [];
private _soldierArray = [];
private _classNames = [];
private _activeGarrisonRef = ([_markerName, true] call MFUNC(_getGarrison)) select 2;

// Avoid spawn position on water
while { _spawnPos isEqualTo [] || surfaceIsWater _spawnPos; } do {
    _spawnPos = _markerPos getPos [random _capRange, random 360];
};

// TODO: TBD: ditto 'placeholders' etc just use side itself
// Set array to select soldier classnames from
private _side = switch (_ownerNumber) do {
    case 2: {
        _soldierArray = [KPLIB_preset_sideF] call KPLIB_fnc_common_getSoldierArray;
        KPLIB_preset_sideF;
    };
    default {
        _soldierArray = [] call KPLIB_fnc_common_getSoldierArray;
        KPLIB_preset_sideE;
    };
};

// Fetch unit classnames
for Q(_i) from 1 to _count do {
    _classNames pushBack (selectRandom _soldierArray);
};

// Create group
_grp = [_classNames, _spawnPos, _side] call KPLIB_fnc_common_createGroup;

// Add units of created group to active garrison array
{ _activeGarrisonRef pushBack _x; } forEach (units _grp);

// // TODO: TBD: !DEBUG! Add group to Zeus
// {
//     _x addCuratorEditableObjects [units _grp, true]
// } forEach allCurators;

// Remove possible initialization waypoints
{ deleteWaypoint [_grp, 0]; } forEach (waypoints _grp);

// Make sure every soldier is following the leader
{ _x doFollow (leader _grp); } forEach (units _grp);

// TODO: TBD: 'task defend' or leave it up to the caller, i.e. depending a the sector activation state machine, etc...
// Order group to defend sector position
[_grp, _markerPos, _capRange, _defendThreshold, _defendPatrolChance, _defendHoldChance] call CBA_fnc_taskDefend;

// Return group
_grp;
