/*
    KPLIB_fnc_resources_refund

    File: fn_resources_refund.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-03-31
    Last Update: 2021-03-05 01:07:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Refunds given amount of resources to the provided location.

    Parameter(s):
        _location - sector or FOB marker where the resources should be refunded [STRING, defaults: ""]
        _supplies - amount of supplies to refund [NUMBER, defaults: 0]
        _ammo - amount of ammo to refund [NUMBER, defaults: 0]
        _fuel - amount of fuel to refund [NUMBER, defaults: 0]
        _range - range about which to scan for available storage objects [SCALAR, default: KPLIB_param_fobRange]

    Returns:
        Refund successful [BOOL]
 */

params [
    ["_location", "", [""]]
    , ["_supplies", 0, [0]]
    , ["_ammo", 0, [0]]
    , ["_fuel", 0, [0]]
    , ["_range", KPLIB_param_fobRange, [0]]
];

// Exit if no location is given
if (_location isEqualTo "") exitWith {false};

// Get all storage areas in the vicinity of the marker
private _storages = nearestObjects [markerPos _location, KPLIB_resources_storageClasses, _range];

// Check if the location even has the needed space
private _supplyCrates = ceil (_supplies / KPLIB_param_crateVolume);
private _ammoCrates = ceil (_ammo / KPLIB_param_crateVolume);
private _fuelCrates = ceil (_fuel / KPLIB_param_crateVolume);
private _crateCount = _supplyCrates + _ammoCrates + _fuelCrates;
private _crateCapacity = 0;
{
    _crateCapacity = _crateCapacity + ([_x] call KPLIB_fnc_resources_getStorageSpace);
} forEach _storages;

if (_crateCapacity < _crateCount) exitWith {
    false
};

// Add resources based on given amount
private _storage = objNull;
private _crate = objNull;

while {(_supplies + _ammo + _fuel) > 0} do {
    _storage = _storages select (_storages findIf {([_x] call KPLIB_fnc_resources_getStorageSpace) > 0});
    switch (true) do {
        case (_supplies > 0): {
            _crate = ["Supply", getPosATL _storage, (_supplies min KPLIB_param_crateVolume)] call KPLIB_fnc_resources_createCrate;
            _supplies = _supplies - KPLIB_param_crateVolume;
        };
        case (_ammo > 0): {
            _crate = ["Ammo", getPosATL _storage, (_ammo min KPLIB_param_crateVolume)] call KPLIB_fnc_resources_createCrate;
            _ammo = _ammo - KPLIB_param_crateVolume;
        };
        case (_fuel > 0): {
            _crate = ["Fuel", getPosATL _storage, (_fuel min KPLIB_param_crateVolume)] call KPLIB_fnc_resources_createCrate;

            _fuel = _fuel - KPLIB_param_crateVolume;
        };
    };
    [_crate] call KPLIB_fnc_resources_storeCrate;
};

// TODO: TBD: instead of SnS... need a simple "collapse" ...
// TODO: TBD: and then do we really need to SnS "all" of the storages? of the ones that had something actually STORED (?)
// TODO: TBD: then I think there also needs to ba a consolidate, but this is for a future time...
// Reorder the crates on all storages to close the possible gaps
{
    [_x] call KPLIB_fnc_resources_stackNsort;
} forEach _storages;

true;
