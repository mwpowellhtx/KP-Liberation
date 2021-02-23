/*
    KPLIB_fnc_resources_getStorageValue

    File: fn_resources_getStorageValue.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-12-16
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Gets the amount of resources from the stored crates of a given storage.

    Parameter(s):
        _storage - Storage which should be ordered [OBJECT, defaults to objNull]

    Returns:
        Amount of supplies, ammo and fuel [ARRAY]
 */

// TODO: TBD: will leave this one alone for now...
// TODO: TBD: however I think we can do better, and potentially support multiple storages
// TODO: TBD: while at the same time rolling up 'KPLIB_resources_storageValue' summaries...

params [
    ["_storage", objNull, [objNull]]
];

// Exit if no storage was given
if (isNull _storage) exitWith {[0, 0, 0]};

// Fetch the amount of resources from storage
private _supplies = 0;
private _ammo = 0;
private _fuel = 0;

private _crates = [_storage] call KPLIB_fnc_resources_getAttachedCrates;

{
    switch (typeOf _x) do {
        case KPLIB_preset_crateSupplyE;
        case KPLIB_preset_crateSupplyF: {_supplies = _supplies + (_x getVariable ["KPLIB_resources_crateValue", 0])};
        case KPLIB_preset_crateAmmoE;
        case KPLIB_preset_crateAmmoF: {_ammo = _ammo + (_x getVariable ["KPLIB_resources_crateValue", 0])};
        case KPLIB_preset_crateFuelE;
        case KPLIB_preset_crateFuelF: {_fuel = _fuel + (_x getVariable ["KPLIB_resources_crateValue", 0])};
    };
} forEach _crates;

[_supplies, _ammo, _fuel];
