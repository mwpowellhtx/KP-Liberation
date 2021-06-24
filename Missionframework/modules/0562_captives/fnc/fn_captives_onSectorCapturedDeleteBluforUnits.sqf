#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedDeleteBluforUnits

    File: fn_captives_onSectorCapturedDeleteBluforUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 19:27:22
    Last Update: 2021-06-16 19:27:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Removes the non player UNITS from the area. Ignores PLAYER UNITS, or units in which
        a PLAYER is their LEADER.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_sector", locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedDeleteBluforUnits_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedDeleteBluforUnits_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (_debug) then {
    // TODO: TBD: logging...
};

if (!(_sideOnActivation == KPLIB_preset_sideF || _captured)) exitWith {
    false;
};

private _capUnitsF = _sector getVariable [Q(KPLIB_sectors_capUnitsF), []];
private _unitsToDelete = _capUnitsF select { !(isPlayer _x || isPlayer leader _x); };

{ deleteVehicle _x; } forEach _unitsToDelete;

if (_debug) then {
    // TODO: TBD: logging...
};

true;
