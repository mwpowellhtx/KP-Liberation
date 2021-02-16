/*
    KPLIB_fnc_resources_onPopulateStorage

    File: fn_resources_onPopulateStorage.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-02-15 23:20:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Populates the '_storageContainer' with the '_storageValue' as apportioned by '_crateVolume'.
        For now, assumes there is sufficient room to receive the credit.

    Parameter(s):
        _storageContainer - the storage container being repopulated; assumes that a
                'KPLIB_resources_storageValue' global variable has previously been
                set [OBJECT, default: objNull]
                    - variable value [ARRAY, default: KPLIB_resources_storageValueDefault]
        _crateVolume - the volume by which to apportion '_storageValue' [SCALAR, default: KPLIB_param_crateVolume]

    Returns:
        Function reached the end [BOOL]
 */

params [
    ["_storageContainer", objNull, [objNull]]
    , ["_crateVolume", KPLIB_param_crateVolume, [0]]
];

private _storageValue = _storageContainer getVariable ["KPLIB_resources_storageValue", KPLIB_resources_storageValueDefault];

private _transaction = [
    ["Supply", _storageValue#0]
    , ["Ammo", _storageValue#1]
    , ["Fuel", _storageValue#2]
];

// TODO: TBD: in the future, transactions may either be credits or debits, and apply accordingly as such...
// Which then is either a debit or a credit, and applied accordingly...
{
    // We assume the credit, obviously, but the algo works the same in debit direction...
    _x params [
        ["_resource", "", [""]]
        , ["_credit", 0, [0]]
    ];

    private ["_value", "_crate"];

    while {_credit > 0} do {
        _value = _credit min _crateVolume;
        _crate = [_resource, getPosATL _storageContainer, _value] call KPLIB_fnc_resources_createCrate;
        // TODO: TBD: also, evantually, which, store crate, etc...
        // TODO: TBD: there is really no difference between a storage container and a transport where this aspect is concerned...
        // TODO: TBD: similarly for "load/store" and "unload/unstore" ... eventually...
        [_crate, _storageContainer] call KPLIB_fnc_resources_storeCrate;
        _credit = _credit - _value;
    };
} forEach _transaction;

true;
