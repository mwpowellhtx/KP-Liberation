/*
    KPLIB_fnc_production_callback_onWithoutStorageContainer

    File: fn_production_callback_onWithoutStorageContainer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 00:22:39
    Last Update: 2021-05-18 16:58:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the SECTOR by the MARKER NAME exists without an already built
        STORAGE CONTAINER object.

    Parameter(s):
        _target - a TARGET object to consider [OBJECT, default: player]
        _range - RANGE about which to consider the TARGET near the MARKER [SCALAR, default: KPLIB_param_sectors_capRange]
        _markerName - a MARKER NAME about which to consider [STRING, default: ""]
        _classNames - the class names being considered [ARRAY, default: KPLIB_resources_factoryStorageClasses]

    Returns:
        Whether there are no storage containers near the '_markerName' [BOOL]
 */

// TODO: TBD: several things smell bad about this one...
// TODO: TBD: 1. what callback does this serve?
// TODO: TBD: 2. we need player/target? as well as marker name?
// TODO: TBD: 3. just use marker name if possible

params [
    ["_target", player, [objNull]]
    , ["_range", KPLIB_param_sectors_capRange, [0]]
    , ["_markerName", "", [""]]
    , ["_classNames", KPLIB_resources_factoryStorageClasses, [[]]]
];

// // TODO: TBD: we could use the cross-module dependency...
// // TODO: TBD: or simply use the primitives for that matter...
// private _storageContainers = [markerPos _markerName, _range, _classNames] call KPLIB_fnc_resources_getStorages;
private _storageContainers = nearestObjects [markerPos _markerName, _classNames, _range];

private _selected = _storageContainers select {
    (_x getVariable ["KPLIB_sectors_markerName", ""]) isEqualTo _markerName;
};

_selected isEqualTo [];
