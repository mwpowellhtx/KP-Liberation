/*
    KPLIB_fnc_production_callback_onWithoutStorageContainer

    File: fn_production_callback_onWithoutStorageContainer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 00:22:39
    Last Update: 2021-04-16 08:47:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_markerName' exists without an already built storage container.

    Parameter(s):
        _target - a target object to consider near the '_markerName' [OBJECT, default: player]
        _range - the range about which to consider near the '_markerName' [SCALAR, default: KPLIB_param_sectors_capRange]
        _markerName - the marker name at which to consider [STRING, default: ""]
        _classNames - the class names being considered [ARRAY, default: KPLIB_resources_factoryStorageClasses]

    Returns:
        Whether there are no storage containers near the '_markerName' [BOOL]

    Dependencies:
        0210_resources
*/

params [
    ["_target", player, [objNull]]
    , ["_range", KPLIB_param_sectors_capRange, [0]]
    , ["_markerName", "", [""]]
    , ["_classNames", KPLIB_resources_factoryStorageClasses, [[]]]
];

private _storages = [markerPos _markerName, _range, _classNames] call KPLIB_fnc_resources_getStorages;

private _selected = _storages select {
    private _storageMarkerName = _x getVariable ["KPLIB_sector_markerName", ""];
    _storageMarkerName isEqualTo _markerName;
};

_selected isEqualTo [];
