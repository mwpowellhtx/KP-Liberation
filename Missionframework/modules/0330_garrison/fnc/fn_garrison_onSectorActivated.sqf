#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorActivated

    File: fn_garrison_onSectorActivated.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-20
    Last Update: 2021-04-20 22:59:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles the spawning of the sector garrison which is stored in the garrison array.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onSpawn_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

if (isServer) then {
    [format ["[fn_garrison_onSectorActivated] Spawn for %1", _markerName], "GARRISON", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: what to do about garrison for air assets? paratroopers? CAS? CAP?
// TODO: TBD: okay, so we need to do some refactoring, recasting...
// TODO: TBD: as far as paratroopers, cas, cap, etc, those are 'missions' that get triggered along the way...

// Initialize local variables
private _garrison = [_markerName] call MFUNC(_getGarrison);
private _sectorOwner = _garrison#1;
private _sectorOwnerSide = sideEmpty;
private _soldierCount = _garrison#2;
private _squadCount = floor (_soldierCount / 6);
private _leftSolders = _soldierCount % 6;
private _lightVehicles = _garrison#3;
private _heavyVehicles = _garrison#4;

// Create active garrison array entry
MVAR(_active) pushBack [_markerName, _sectorOwner, [], [], [], []];

// TODO: TBD: ditto "side" placeholders...
// Get current sector owner
switch (_sectorOwner) do {
    case 0;
    case 1: { _sectorOwnerSide = KPLIB_preset_sideE; };
    case 2: { _sectorOwnerSide = KPLIB_preset_sideF; };
    default { _sectorOwnerSide = KPLIB_preset_sideE; };
};

// Spawn full infantry squads
for "_i" from 1 to _squadCount do {
    // Spawn infantry squads with small delays. Otherwise it could cause a small freeze, when there >3 squads at a sector.
    [
        { _this call MFUNC(_onSpawnSectorInfantry); }
        , [_markerName, _sectorOwner]
        , _i
    ] call CBA_fnc_waitAndExecute;
};

// Spawn remaining soldiers
if (_leftSolders > 0) then {
    [_markerName, _sectorOwner, _leftSolders] call MFUNC(_onSpawnSectorInfantry);
};

// Spawn light vehicles
{
    [
        { _this call MFUNC(_onSpawnSectorVehicle); }
        , [_markerName, _x, _sectorOwnerSide]
        , _squadCount + _forEachIndex + 1
    ] call CBA_fnc_waitAndExecute;
} forEach _lightVehicles;

// Spawn heavy vehicles
{
    [
        { _this call MFUNC(_onSpawnSectorVehicle); }
        , [_markerName, _x, _sectorOwnerSide, Q(heavy)]
        , _squadCount + (count _lightvehicles) + _forEachIndex + 1
    ] call CBA_fnc_waitAndExecute;
} forEach _heavyVehicles;

true;
