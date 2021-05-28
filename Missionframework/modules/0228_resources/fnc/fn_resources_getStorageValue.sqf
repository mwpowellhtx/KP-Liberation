#include "script_component.hpp"
/*
    KPLIB_fnc_resources_getStorageValue

    File: fn_resources_getStorageValue.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-05-27 19:20:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a STORAGE VALUE tuple corresponding to the STORAGE objects.

    Parameter(s):
        _storage - one or more STORAGE objects to summarize [OBJECT|ARRAY, default: objNull]

    Returns:
        STORAGE VALUE tuple [ARRAY]
            [
                _supply
                , _ammo
                , _fuel
            ]
 */

// TODO: TBD: will leave this one alone for now...
// TODO: TBD: however I think we can do better, and potentially support multiple storages
// TODO: TBD: while at the same time rolling up 'KPLIB_resources_storageValue' summaries...

params [
    [Q(_storage), objNull, [objNull, []]]
];

// Works fine null or not null because the GET function works
private _crates = [_storage] call KPLIB_fnc_resources_getAttachedCrates;

// Summarize the SUPPLY+AMMO+FUEL buckets across all of the CRATES
private _storageValue = [
    [KPLIB_preset_crateSupplyE, KPLIB_preset_crateSupplyF]
    , [KPLIB_preset_crateAmmoE, KPLIB_preset_crateAmmoF]
    , [KPLIB_preset_crateFuelE, KPLIB_preset_crateFuelF]
] apply {
    private _classNames = _x;
    private _selected = _crates select { typeOf _x in _classNames; };
    [_selected apply { [_x] call MFUNC(_getCrateValue); }] call KPLIB_fnc_linq_sum;
};

_storageValue;
