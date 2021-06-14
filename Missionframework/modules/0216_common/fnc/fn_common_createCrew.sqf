/*
    KPLIB_fnc_common_createCrew

    File: fn_common_createCrew.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-25
    Last Update: 2021-06-14 16:40:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Spawns a full crew for given vehicle. Currently only implemented for empty vehicles.

    Parameter(s):
        _vehicle - a vehicle object which should get a crew [OBJECT, default: objNull]
        _side - the side of the crew [SIDE, default: KPLIB_preset_sideE]

    Returns:
        A GRP constituted by the units and vehicle [GROUP]
 */

params [
    ["_vehicle", objNull, [objNull]]
    , ["_side", KPLIB_preset_sideE, [sideEmpty]]
];

private _debug = KPLIB_param_common_createCrew_debug
    || (_vehicle getVariable ["KPLIB_common_createCrew_debug", false])
    ;

private _grp = grpNull;

// Exit when no or destroyed vehicle was given
if (isNull _vehicle || !alive _vehicle) exitWith {
    _grp;
};

// Get driver class depending on vehicle type
private _driverType = switch (true) do {
    // Civilians and resitance do not have specialized infantry units
    case (_side in [KPLIB_preset_sideC, KPLIB_preset_sideR]):   { "units";          };
    case (_vehicle isKindOf "Plane"):                           { "rsPilotJet";     };
    case (_vehicle isKindOf "Helicopter"):                      { "rsPilotHeli";    };
    default                                                     { "rsCrewmanVeh";   };
};

private _crewClasses = [[_driverType, _side] call KPLIB_fnc_common_getPresetClass];

// Get crew class depending on vehicle type
private _crewType = switch (true) do {
    // Civilians and resitance do not have specialized infantry units
    case (_side in [KPLIB_preset_sideC, KPLIB_preset_sideR]):   { "units";          };
    case (_vehicle isKindOf "Plane"):                           { "rsPilotJet";     };
    case (_vehicle isKindOf "Helicopter"):                      { "rsCrewmanHeli";  };
    default                                                     { "rsCrewmanVeh";   };
};

private _driverTurret = -1;
private _turrets = [_driverTurret];
_turrets append (allTurrets _vehicle);

_crewClasses append (_turrets apply { [_crewType, _side] call KPLIB_fnc_common_getPresetClass; });

// Spawn group and move into to vehicle
_grp = [_crewClasses, getPos _vehicle, _side] call KPLIB_fnc_common_createGroup;

private _grpUnits = units _grp;

// Move the units into the vehicle, -1 indicates driver
{
    private _unit = _grpUnits select _forEachIndex;
    switch (_forEachIndex) do {
        case 0: { _unit moveInDriver _vehicle; };
        default { _unit moveInTurret [_vehicle, _x]; };
    };
} forEach _turrets;

// Remove excess units from group
private _unitsToDelete = _grpUnits select { isNull objectParent _x; };
{ deleteVehicle _x; } foreach _unitsToDelete;

// Assign vehicle to group and make sure the commander is group leader
_grp addVehicle _vehicle;
_grp selectLeader (commander _vehicle);

// Return created crew
_grp;
