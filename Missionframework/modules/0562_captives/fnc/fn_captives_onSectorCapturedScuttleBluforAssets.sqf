#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedScuttleBluforAssets

    File: fn_captives_onSectorCapturedScuttleBluforAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 13:40:05
    Last Update: 2021-06-14 17:20:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Everything else being equal, we shall expect sector arrays to have been
        updated, and 'KPLIB_captured' flag set on the sector itself.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/crew
        https://community.bistudio.com/wiki/deleteVehicle
        https://community.bistudio.com/wiki/deleteVehicleCrew
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedScuttleBluforAssets_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedScuttleBluforAssets_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (!(_sideOnActivation == KPLIB_preset_sideF || _captured)) exitWith {
    false;
};

// Leave any VEHICLES with at least one PLAYER alone
private _capVehicles = _sector getVariable [Q(KPLIB_sectors_capVehiclesF), []];
private _vehiclesToKill = _capVehicles select { !isPlayer _x; };

{
    private _vehicle = _x;
    private _scuttleDelay = random MPARAM(_bluforScuttleTimeout) max MPARAM(_minScuttleTimeout);
    _vehicle setVariable [QMVAR(_scuttleDelay), _scuttleDelay, true];

    [
        {
            private _vehicle = _this;
            private _crewToDelete = (crew _vehicle) select { !isPlayer _x; };
            { _vehicle deleteVehicleCrew _x; } forEach _crewToDelete;
            _vehicle setDamage 1;
        }
        , _vehicle
        , _scuttleDelay
    ] call CBA_fnc_waitAndExecute;

} forEach _vehiclesToKill;

true;
