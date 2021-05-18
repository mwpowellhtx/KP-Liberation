/*
    KPLIB_fnc_resources_getFobStorages

    File: fn_resources_getFobStorages.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 20:44:04
    Last Update: 2021-05-17 20:26:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the storage container '_classNames' within '_range' of the factory sector '_markerName'.

    Parameter(s):
        _markerName - the marker name corresponding to the factory in question [STRING, default: ""]
        _classNames - the storage class names to consider during the inquiry [ARRAY, default: []]
        _range - the range about which to inquire about storage containers [SCALAR, default: 0]

    Returns:
        Storage containers in proximity of the designated factory marker [ARRAY]
 */

params [
    ["_fob", [], [[]], 6]
    , ["_classNames", KPLIB_resources_storageClassesF, [[]]]
    , ["_range", KPLIB_param_fobs_range, [0]]
];

// This version is a bit more in depth parsing through the FOB tuple, but not terribly so...
private _pos = _fob call {
    [
        (_this#0)
        , (_this#4)
    ] params [
        ["_markerName", "", [""]]
        , ["_defaultPos", KPLIB_zeroPos, [[]], 3]
    ];

    // Marker established but allows should there not be yet
    if (toLower _markerName in allMapMarkers) exitWith {
        markerPos _markerName;
    };

    _defaultPos;
};

private _candidates = nearestObjects [_pos, _classNames, _range];

// TODO: TBD: "when" is this being set on the object? before or after build is confirmed? / https://github.com/mwpowellhtx/KP-Liberation/issues/60
// Ditto notes re: factory storages, discerning between the two
private _retval = _candidates select {
    !((_x getVariable ["KPLIB_fob_originalUuid", ""]) isEqualTo "");
};

_retval;
