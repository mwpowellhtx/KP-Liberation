#include "script_component.hpp"
/*
    KPLIB_fnc_resources_getStorageValue

    File: fn_resources_getStorageValue.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-05-05 22:26:28
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
    [Q(_storage), objNull, [objNull]]
];

// Fetch the amount of resources from storage
private _default = 0;
private _supplies = 0;
private _ammo = 0;
private _fuel = 0;

// Works fine null or not null because the GET function works
private _crates = [[_storage]] call KPLIB_fnc_resources_getAttachedCrates;

{
    switch (typeOf _x) do {
        case KPLIB_preset_crateSupplyE;
        case KPLIB_preset_crateSupplyF: {
            _supplies = _supplies + (_x getVariable [QMVAR(_crateValue), _default]);
        };
        case KPLIB_preset_crateAmmoE;
        case KPLIB_preset_crateAmmoF: {
            _ammo = _ammo + (_x getVariable [QMVAR(_crateValue), _default]);
        };
        case KPLIB_preset_crateFuelE;
        case KPLIB_preset_crateFuelF: {
            _fuel = _fuel + (_x getVariable [QMVAR(_crateValue), _default]);
        };
    };
} forEach _crates;

[_supplies, _ammo, _fuel];
