/*
    KPLIB_fnc_build_canBuildStorage

    File: fn_build_canBuildStorage.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 09:27:35
    Last Update: 2021-05-22 12:56:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the PLAYER may BUILD STORAGE CONTAINER in proximity
        to a BLUFOR FACTORY SECTOR. Prohibitions on the action include whether
        the player has PERMISSIONS do BUILD and to support LOGISTICS, whether
        there is already a STORAGE CONTAINER built for the sector, and whether
        there are any other players already in the process of building.

    Parameter(s):
        _player - gauging whether the PLAYER may BUILD STORAGE [OBJECT, default: player]

    Returns:
        The afore mentioned conditions have been met [BOOL]

    References:
        https://en.wikipedia.org/wiki/Venn_diagram
 */

params [
    ["_player", player, [objNull]]
];

// Rule out when player is NULL or !ALIVE
if (isNull _player || !alive _player) exitWith { false; };

[
    _player getVariable ["KPLIB_sectors_markerName", ""]
    , [] call KPLIB_fnc_sectors_getBluforFactorySectors
    , [["Build", "Logistics"], nil, _player] call KPLIB_fnc_permission_checkPermissions
] params [
    "_markerName"
    , "_bluforFactorySectors"
    , "_permission"
];

private _storageExists = [_markerName] call {
    params [
        ["_markerName", "", [""]]
    ];
    private _objects = nearestObjects [markerPos _markerName, [KPLIB_preset_storageSmallF], KPLIB_param_sectors_capRange];
    private _storageContainers = _objects select { (_x getVariable ["KPLIB_sectors_markerName", ""]) isEqualTo _markerName; };
    count _storageContainers > 0;
};

private _buildingPlayers = [
    ["KPLIB_sectors_markerName", "KPLIB_build_markerName"]
    , [_markerName, _markerName]
] call {
    params [
        ["_vars", [], [[]]]
        , ["_expected", [], [[]]]
    ];    
    allPlayers select {
        private _other = _x;
        private _actual = _vars apply { _other getVariable [_x, ""]; };
        !(_other isEqualTo _player || _actual isEqualTo _expected);
    };
};

_permission
    && _markerName in _bluforFactorySectors
    && !_storageExists
    && _buildingPlayers isEqualTo []
    ;
