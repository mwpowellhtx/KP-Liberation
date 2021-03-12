/*
    KPLIB_fnc_resources_pay

    File: fn_resources_pay.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-02-05 12:43:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Removes given amount of resources from the provided location.

    Parameter(s):
        _markerName - Sector or FOB marker from where to pay the resources from [STRING, default: ""]
        _supplies   - Amount of supplies to pay                                 [NUMBER, default: 0]
        _ammo       - Amount of ammo to pay                                     [NUMBER, default: 0]
        _fuel       - Amount of fuel to pay                                     [NUMBER, default: 0]
        _range      - Range about which to consider storage containers          [NUMBER, default: KPLIB_param_fobRange]

    Returns:
        Payment successful  [BOOL]
*/

private _debug = [
    [
        {KPLIB_param_resources_pay_debug}
    ]
] call KPLIB_fnc_debug_debug;

// TODO: TBD: this is a lot of code, switches, and so forth...
// TODO: TBD: we think we can do better if we assume a couple of things about a transaction, shape of:
// TODO: TBD: [_resourceIndex, _amount], where (_resourceIndex in [0, 1, 2]) ...
// TODO: TBD: ... and _amount is the _amount, or amount of change, whether debit or credit
// TODO: TBD: HOWEVER... not, not, NOT this sprint... maybe a future sprint do we look to simplify that whole thing...
params [
    ["_markerName", [] call KPLIB_fnc_common_getPlayerFob, [""]]
    , ["_supplies", 0, [0]]
    , ["_ammo", 0, [0]]
    , ["_fuel", 0, [0]]
    , ["_range", KPLIB_param_fobRange, [0]]
];

private _bill = [_supplies, _ammo, _fuel];

if (_debug) then {
    [format ["[fn_resources_pay] Entering: [_markerName, markerText _markerName, _bill, _range]: %1"
        , str [_markerName, markerText _markerName, _bill, _range]], "RESOURCES", true] call KPLIB_fnc_common_log;
};

[
    _bill isEqualTo KPLIB_resources_storageValueDefault
    , !(_markerName isEqualTo "")
] params [
    "_zeroBill"
    , "_validMarker"
];

// Exit early when ZERO BILL or when MARKER INVALID
if (_zeroBill) exitWith { true; };
if (!_validMarker) exitWith { false; };

// Check if the location even has the needed amount of resources
([_markerName] call KPLIB_fnc_resources_getResTotal) params [
    "_totalSupplies"
    , "_totalAmmo"
    , "_totalFuel"
];

if (_totalSupplies < _supplies || _totalAmmo < _ammo || _totalFuel < _fuel) exitWith {
    if (_debug) then {
        [format ["[fn_resources_pay] Insufficient resources: [_markerName, markerText _markerName, _bill, [_totalSupplies, _totalAmmo, _totalFuel]]: %1"
            , str [_markerName, markerText _markerName, _bill, [_totalSupplies, _totalAmmo, _totalFuel]]], "RESOURCES", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Get all storage areas in the vicinity of the marker
private _storages = nearestObjects [markerPos _markerName, KPLIB_resources_storageClasses, _range];

// Maintain the set of ALL crates, we will draw from this after the transaction has been resolved
private _allCrates = [_storages] call KPLIB_fnc_resources_getAttachedCrates;

// Identify each of the resource crates by typeOf
private _allCratesByTypeOf = [
    [KPLIB_preset_crateSupplyE, KPLIB_preset_crateSupplyF]
    , [KPLIB_preset_crateAmmoE, KPLIB_preset_crateAmmoF]
    , [KPLIB_preset_crateFuelE, KPLIB_preset_crateFuelF]
] apply {
    private _classNames = _x;
    _allCrates select { typeof _x in _classNames; };
};

_allCratesByTypeOf params [
    ["_supplyCrates", [], [[]]]
    , ["_ammoCrates", [], [[]]]
    , ["_fuelCrates", [], [[]]]
];

if (_debug) then {
    private _storageNedIds = _storages apply { netId _x; };
    private _supplyNetIds = _supplyCrates apply { netId _x; };
    private _ammoNetIds = _ammoCrates apply { netId _x; };
    private _fuelNetIds = _fuelCrates apply { netId _x; };
    [format ["[fn_resources_pay] Resolving: [_markerName, _bill, [count _storages, _storageNedIds], [count _supplyCrates, _supplyNetIds], [count _ammoCrates, _ammoNetIds], [count _fuelCrates, _fuelNetIds]]: %1"
        , str [_markerName, _bill, [count _storages, _storageNedIds], [count _supplyCrates, _supplyNetIds], [count _ammoCrates, _ammoNetIds], [count _fuelCrates, _fuelNetIds]]], "RESOURCES", true] call KPLIB_fnc_common_log;
};

// Remove crates according to requested resource
{
    _x params [
        ["_resource", 0, [0]]
        , ["_crates", [], [[]]]
    ];
    while {_resource > 0} do {
        // Always draw from the crate of least resource first
        private _ordered = [_crates, [], { [_x] call KPLIB_fnc_resources_getCrateValue; }, "ascend"] call BIS_fnc_sortBy;
        // And because we may also have exhausted crates, remove them from the set
        _ordered = _ordered select { ([_x] call KPLIB_fnc_resources_getCrateValue) > 0; };
        private _crate = _ordered#0;
        private _value = [_crate] call KPLIB_fnc_resources_getCrateValue;

        // Draw from the crate resource, either exhausted or leaving some remaining
        if (_resource >= _value) then {
            _resource = _resource - _value;
            _value = 0;
        } else {
            _value = _value - _resource;
            _resource = 0;
        };

        [_crate, _value] call KPLIB_fnc_resources_setCrateValue;

        if (_debug) then {
            [format ["[fn_resources_pay] Crate value updated: [count _allCrates, count _crates, count _ordered, _value, netId _crate]: %1"
                , str [count _allCrates, count _crates, count _ordered, _value, netId _crate]], "RESOURCES", true] call KPLIB_fnc_common_log;
        };
    };
} forEach [
    [_supplies, _supplyCrates]
    , [_ammo, _ammoCrates]
    , [_fuel, _fuelCrates]
];

// GC the crates which resource is now EXHAUSTED
private _toGC = _allCrates select { 0 == ([_x] call KPLIB_fnc_resources_getCrateValue); };

if (_debug && count _toGC > 0) then {
    [format ["[fn_resources_pay] GC crates: [count _allCrates, count _toGC]: %1"
        , str [count _allCrates, count _toGC]], "RESOURCES", true] call KPLIB_fnc_common_log;
};

{
    private _crate = _x;
    detach _crate;
    deleteVehicle _crate;
} forEach _toGC;

// Reorder the crates on all storages to close the possible gaps
{
    [_x] call KPLIB_fnc_resources_orderStorage;
} forEach _storages;

[] call KPLIB_fnc_init_save;

if (_debug) then {
    ["[fn_resources_pay] Fini", "RESOURCES", true] call KPLIB_fnc_common_log;
};

true;
