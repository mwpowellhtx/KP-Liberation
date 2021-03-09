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

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

/* Unused bits:
 *      _0: _alphaPos
 *      _1: _alphaMarker
 *      _2: _alphaMarkerText
 */
_endpoints params [
    ["_alpha", [], [[]]]
];
_alpha params [
    "_0"
    , "_1"
    , "_2"
    , ["_alphaBillValue", +KPLIB_resources_storageValueDefault, [[]]]
];

private _alphaBillCrates = _alphaBillValue apply {
    ([_x] call KPLIB_fnc_resources_estimateCrates);
};

_alphaBillCrates params [
    ["_alphaSupply", 0, [0]]
    , ["_alphaAmmo", 0, [0]]
    , ["_alphaFuel", 0, [0]]
];

// Constrain the available sets by the bill
private _loads = _loadTemplates select {
    _x params [
        ["_supply", 0, [0]]
        , ["_ammo", 0, [0]]
        , ["_fuel", 0, [0]]
    ];
    _supply <= _alphaSupply
        && _ammo <= _alphaAmmo
        && _fuel <= _alphaFuel;
};

// There may not be any matches
if (count _loads == 0) exitWith {
    +KPLIB_resources_storageValueDefaults;
};

private _summarize = {
    params [
        ["_supply", 0, [0]]
        , ["_ammo", 0, [0]]
        , ["_fuel", 0, [0]]
    ];
    _supply + _ammo + _fuel;
};

// ONE LOAD is a no brainer...
private _descending = if (count _loads == 1) then {
    (_loads#0);
} else {
    // We also want the widest possible distribution, 3, 2, or 1, regardless of crates, volumes
    [_loads, [], { (_x apply { _x min 1; }) call _summarize; }, "descend"] call BIS_fnc_sortBy;
};

// Use the FIRST item to further constraint the CANDIDATES
private _candidates = [(_descending#0) call _summarize] call {
    params [
        ["_coverage", 0, [0]]
    ];
    _descending select { (_x call _summarize) == _coverage; };
};

// Now we have a FILTER against which we may present the next load
private _filter = selectRandom _candidates;

// Now we need the LOAD in terms of VOLUME
private _crateVolumes = _filter apply { (_x * KPLIB_param_crateVolume); };

_crateVolumes params [
    ["_supplyVolume", 0, [0]]
    , ["_ammoVolume", 0, [0]]
    , ["_fuelVolume", 0, [0]]
];

// Load the maximum possible, either FULL VOLUME, or whatever ALPHA is requesting
private _retval = [
    _supplyVolume max _alphaSupply
    , _ammoVolume max _alphaAmmo
    , _fuelVolume max _alphaFuel
];

_retval;
