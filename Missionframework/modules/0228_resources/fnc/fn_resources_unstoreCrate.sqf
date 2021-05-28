#include "script_component.hpp"
/*
    KPLIB_fnc_resources_unstoreCrate

    File: fn_resources_unstoreCrate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-15
    Last Update: 2021-05-05 22:26:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Unstores a crate of given kind from a given storage area.

    Parameter(s):
        _storage    - Storage area from which the crate should be removed   [OBJECT, defaults to objNull]
        _resource   - Type of resource crate                                [STRING, defaults to "Supply"]

    Returns:
        Unstored crate [OBJECT]
 */

params [
    [Q(_storage), objNull, [objNull]]
    , [Q(_resource), MPRESET(_resourceKind_sup), [""]]
];

private _crate = objNull;

// Exit, if no storage or invalid resource type is given
if (isNull _storage || !(_resource in MPRESET(_resourceKinds))) exitWith {
    _crate;
};

// We need to determine for what type of crate we'll looking for
private _validCrates = switch (_resource) do {
    case "Supply": {[KPLIB_preset_crateSupplyE, KPLIB_preset_crateSupplyF]};
    case "Ammo": {[KPLIB_preset_crateAmmoE, KPLIB_preset_crateAmmoF]};
    case "Fuel": {[KPLIB_preset_crateFuelE, KPLIB_preset_crateFuelF]};
};

// Get all stored crates in reverse Order (LIFO)
private _attachedCrates = [_storage] call KPLIB_fnc_resources_getAttachedCrates;
reverse _attachedCrates;

// Check if there is one crate of the desired type and select the crate
private _index = _attachedCrates findIf {(typeOf _x) in _validCrates};

if (_index isEqualTo -1) exitWith {
    [localize "STR_KPLIB_HINT_NOCRATEFOUND"] call KPLIB_fnc_notification_hint;
    objNull
};

_crate = _attachedCrates select _index;

// Define distance from the storage center to unload the crate
private _distance = (((boundingBox _storage) select 1) select 1) + 1.2;

// Get the next free unload position
private _unloadPos = _storage getPos [_distance, (getDir _storage) - 180];

// Increment the distance, when spot is occupied
private _i = 0;
while {!((nearestObjects [_unloadPos, [], 1]) isEqualTo [])} do {
    _i = _i + 1;
    // TODO: TBD: should refactor this calculation to a single place...
    // TODO: TBD: and then perhaps we also parameterize some of it in terms of settings...
    // TODO: TBD: also, should seriously consider in terms of asset spec in the init phases...
    // TODO: TBD: should also concolidate load/store and unload/unstore...
    // TODO: TBD: the pattern is the same, the "objects" are just objects, with positions, etc, so use that to our advantage...
    _unloadPos = _storage getPos [_distance + _i * 1.8, (getDir _storage) - 180];
};

// Detach crate and move to unload position
detach _crate;
_crate setPos _unloadPos;

// Get storage position array depending on storage type
private _attachPositions = [typeOf _storage] call KPLIB_fnc_resources_getAttachArray;

// Reorder the crates to close the possible gap
[_storage] call KPLIB_fnc_resources_orderStorage;

[_storage] call KPLIB_fnc_resources_onAttachedCratesChanged;

// Return unstored crate
_crate;
