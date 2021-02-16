/*
    KPLIB_fnc_resources_onRefreshStorageValues

    File: fn_resources_onRefreshStorageValues.sqf
    Author: Michael W. Powell
    Created: 2021-02-15 20:07:54
    Last Update: 2021-02-15 20:07:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameters:
        _callbackType - overall the callback type invoking the request [STRING, default: ""]
        _storageContainers - the storage container objects whose `KPLIB_resources_storageValue` is being refreshed [ARRAY, default: []]

    Returns:
        The callback completed [BOOL]
 */

params [
    ["_callbackType", "", [""]]
    , ["_storageContainers", [], [[]]]
];

private _readyContainers = _storageContainers select {
    (!isNull _x)
        && alive _x;
};

{
    private _storageValue = [_x] call KPLIB_fnc_resources_getStorageValue;
    _x setVariable ["KPLIB_resources_storageValue", _storageValue, true];
} forEach _readyContainers;

true;
