/*
    KPLIB_fnc_common_createCrew

    File: fn_common_createCrew.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-25
    Last Update: 2021-05-03 16:33:29
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

private _grp = grpNull;

// Exit when no or destroyed vehicle was given
if (isNull _vehicle || !alive _vehicle) exitWith {
    _grp;
};

// Get driver class depending on vehicle type
private _driverType = switch (true) do {
    // Civilians and resitance do not have specialized infantry units
    case (_side in [KPLIB_preset_sideC, KPLIB_preset_sideR]): {"units"};
    case (_vehicle isKindOf "Plane"): {"rsPilotJet"};
    case (_vehicle isKindOf "Helicopter"): {"rsPilotHeli"};
    default {"rsCrewmanVeh"};
};

private _unitClasses = [
    [_driverType, _side] call KPLIB_fnc_common_getPresetClass
];

// Get crew class depending on vehicle type
private _crewType = switch (true) do {
    // Civilians and resitance do not have specialized infantry units
    case (_side in [KPLIB_preset_sideC, KPLIB_preset_sideR]): {"units"};
    case (_vehicle isKindOf "Plane"): {"rsPilotJet"};
    case (_vehicle isKindOf "Helicopter"): {"rsCrewmanHeli"};
    default {"rsCrewmanVeh"};
};

private _turrets = allTurrets _vehicle;

_unitClasses append (_turrets apply {
    [_crewType, _side] call KPLIB_fnc_common_getPresetClass;
});

// Spawn group and move into to vehicle
_grp = [_driverClass + _crewClasses, getPos _vehicle, _side] call KPLIB_fnc_common_createGroup;
_turrets insert [0, -1];
//         Ignored: ^^

// Move the units into the vehicle, -1 indicates driver
{
    if (_forEachIndex isEqualTo 0) then {
        ((units _grp) select _forEachIndex) moveInDriver _vehicle;
    } else {
        ((units _grp) select _forEachIndex) moveInTurret [_vehicle, _x];
    }
} forEach _turrets;

// Remove excess units from group
private _unitsToDelete = units _grp select { isNull objectParent _x; };
{ deleteVehicle _x; } foreach _unitsToDelete;

// Assign vehicle to group and make sure the commander is group leader
_grp addVehicle _vehicle;
_grp selectLeader (commander _vehicle);

// Return created crew
_grp;
