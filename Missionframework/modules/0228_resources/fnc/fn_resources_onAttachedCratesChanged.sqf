/*
    KPLIB_fnc_resources_onAttachedCratesChanged

    File: fn_resources_onAttachedCratesChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 09:42:33
    Last Update: 2021-02-23 09:42:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        For use when the storage crate constituency changes in any way. Recommended not
        to invoke this for each crate being attached or detached, if possible, but wait
        for the entire operation to be completed.

    Parameter(s):
        _storages - a single host OBJECT or an ARRAY of OBJECT instances [OBJECT or ARRAY, default: []]

    Returns:
        The event handler completed [BOOL]
 */

params [
    ["_storages", [], [objNull, []]]
];

_storages = switch (typeName _storages) do {
    case "ARRAY": {_storages;};
    case "OBJECT": {[_storages];};
    default {[];};
};

_storages select {
    private _storageValue = [_x] call KPLIB_fnc_resources_getStorageValue;
    _x setVariable ["KPLIB_resources_storageValues", _storageValue, true];
    true;
};

true;
