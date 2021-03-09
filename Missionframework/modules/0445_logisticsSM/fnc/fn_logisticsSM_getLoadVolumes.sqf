/*
    KPLIB_fnc_logisticsSM_getLoadVolumes

    File: fn_logisticsSM_getLoadVolumes.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-08 09:09:05
    Last Update: 2021-03-08 09:09:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the best possible combination of resource volumes that also offers the
        widest possible supply, ammo, fuel coverage.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _loadTemplates - the LOAD templates from which to choose [ARRAY, default: KPLIB_logisticsSM_fullLoads]

    Returns:
        A [S, A, F] storage value tuple [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_loadTemplates", +KPLIB_logisticsSM_fullLoads, [[]]]
];

// Dissect the endpoints, alpha, and bill
([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

_endpoints params [
    ["_alpha", [], [[]]]
];

// Do not care about the other alpha components
_alpha params [
    "_0"
    , "_1"
    , "_2"
    , ["_alphaBillValue", +KPLIB_resources_storageValueDefault, [[]]]
];

// We need the alpha bill as raw as well a crate estimate form
_alphaBillValue params [
    ["_alphaSupply", 0, [0]]
    , ["_alphaAmmo", 0, [0]]
    , ["_alphaFuel", 0, [0]]
];

(_alphaBillValue apply { ([_x] call KPLIB_fnc_resources_estimateCrates); }) params [
    ["_alphaSupplyCrates", 0, [0]]
    , ["_alphaAmmoCrates", 0, [0]]
    , ["_alphaFuelCrates", 0, [0]]
];

// Do a crude filter of the load template crates at first
private _loads = _loadTemplates select {
    _x params [
        ["_supplyCrates", 0, [0]]
        , ["_ammoCrates", 0, [0]]
        , ["_fuelCrates", 0, [0]]
    ];
    _supplyCrates <= _alphaSupplyCrates
        && _ammoCrates <= _alphaAmmoCrates
        && _fuelCrates <= _alphaFuelCrates;
};

// Return early when that rules out any all candidates
if (count _loads == 0) exitWith {
    +KPLIB_resources_storageValueDefault;
};

// Establish a qualitative metric maximizing crates and minimizing zeros
private _each = {
    if (_this == 0) exitWith { -1; };
    (_this*2);
};
private _summarize = {
    ((_this#0) call _each)
    + ((_this#1) call _each)
    + ((_this#2) call _each);
};

// Identify the candidates aligned with the first element coverage
private _descending = if (count _loads == 1) then {
    _loads;
} else {
    [_loads, [], { (_x call _summarize); }, "descend"] call BIS_fnc_sortBy;
};

private _candidates = [(_descending#0) call _summarize] call {
    params [
        ["_coverage", 0, [0]]
    ];
    _descending select { (_x call _summarize) == _coverage; };
};

// And get the the crate volume for the random selection
private _crateVolumes = (selectRandom _candidates) apply { (_x * KPLIB_param_crateVolume); };

_crateVolumes params [
    ["_supplyVolume", 0, [0]]
    , ["_ammoVolume", 0, [0]]
    , ["_fuelVolume", 0, [0]]
];

// Finally constrain the result by the current bill
private _retval = [
    _supplyVolume min _alphaSupply
    , _ammoVolume min _alphaAmmo
    , _fuelVolume min _alphaFuel
];

_retval;
