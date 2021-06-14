/*
    KPLIB_fnc_common_createVehicle

    File: fn_common_createVehicle.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-03
    Last Update: 2021-06-14 16:38:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a newly spawned vehicle at the given position and direction. Supports
        spawning air vehicles or paradrop vehicles, when z > KPLIB_param_common_airSpawnDeck.
        Raises the 'KPLIB_vehicle_created' event upon successful creation.

    Parameter(s):
        _className - class sname of the vehicle which should be spawned [STRING, default: ""]
        _spawnPos - position ATL where the vehicle should be spawned, paradropped
            when z > KPLIB_param_common_airSpawnDeck and no air vehicle
            [POSITION ATL, default: KPLIB_zeroPos]
        _spawnDir - heading for the vehicle from 0 to 360 [NUMBER, default: (random 360)]
        _justSpawn - true to skip all paradrop or air vehicle detection, even
            if z > KPLIB_param_common_airSpawnDeck [BOOL, default: false]
        _withCrew - true to spawn crew for the vehicle [BOOL, default: false]
        _side - side to which this vehicle should belong, when _withCrew == true [SIDE, default: KPLIB_preset_sideE]

    Returns:
        A created vehicle [OBJECT]
 */

params [
    ["_className", "", [""]]
    , ["_spawnPos", KPLIB_zeroPos, [[]], [3]]
    , ["_spawnDir", random 360, [0]]
    , ["_justSpawn", false, [false]]
    , ["_withCrew", false, [false]]
    , ["_side", KPLIB_preset_sideE, [sideEmpty]]
    , ["_specialAttr", "NONE", [""]]
];

private _vehicle = objNull;

// Exit if arguments are missing
if (_className isEqualTo "" || _spawnPos isEqualTo []) exitWith {
    _vehicle;
};

// // Local variables initialization
// private _specialAttr = "NONE";
// TODO: TBD: this needs to be "CAN_COLLIDE" quite probably... especially for FOB rebuilds...
private _paradrop = false;
private _firstPos = KPLIB_zeroPos;
private _reposition = true;
private _velocity = 0;

// Make sure the z value is taken into account, if it shouldn't be skipped
if ((_spawnPos#2) >= KPLIB_param_common_airSpawnDeck && !_justSpawn) then {
    if ((_className isKindOf "Air") && _withCrew) then {
        // Fly for any air vehicle
        _specialAttr = "FLY";

        // Planes spawning mid air are needing a suitable velocity at start
        if (_className isKindOf "Plane") then {
            _velocity = KPLIB_param_common_defaultFixedWingVelocity;
        };
    } else {
        // As it's no air vehicle and/or has no crew, the high z index should execute a paradrop
        _paradrop = true;
    };

    // Spawning mid air shouldn't need any pre- and repositioning
    _firstPos = _spawnPos;
    _reposition = false;
};

// Vehicle initially created at the zero position (if not flying). This is faster then create the vehicle at the desired position.
_vehicle = createVehicle [_className, _firstPos, [], 0, _specialAttr];

// Reposition the vehicle only, if we've placed it at the zeroPosition
if (_reposition) then {
    // Disable damage handling and simulation.
    _vehicle allowDamage false;
    _vehicle enableSimulationGlobal false;

    // Set the vehicle to the position where it should be.
    _vehicle setDir _spawnDir;
    _vehicle setPosATL _spawnPos;
    _vehicle setVectorUp (surfaceNormal (position _vehicle));

    // Activate the simulation again.
    _vehicle enableSimulationGlobal true;
    _vehicle setDamage 0;
    _vehicle allowDamage true;
} else {
    // Apply direction, if no reposition needed
    _vehicle setDir _spawndir;
};

// If we have a plane, let's give it some velocity
if (_velocity > 0) then {
    _vehicle setVelocity [_velocity * (sin _spawnDir), _velocity * (cos _spawnDir), 0];
};

if (_withCrew) then {
    [_vehicle, _side] call KPLIB_fnc_common_createCrew;
};

// Handle paradrop
if (_paradrop) then {
    [objNull, _vehicle] call BIS_fnc_curatorObjectEdited;
};

["KPLIB_vehicle_created", [_vehicle]] call CBA_fnc_globalEvent;

// Return created vehicle
_vehicle;
