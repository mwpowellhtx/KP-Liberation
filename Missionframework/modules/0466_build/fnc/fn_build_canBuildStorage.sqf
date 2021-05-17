/*
    KPLIB_fnc_build_canBuildStorage

    File: fn_build_canBuildStorage.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 09:27:35
    Last Update: 2021-04-16 08:45:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether '_player' can build factory sector storage container.

    Parameter(s):
        _player - the player trying to build the factory sector storage container [OBJECT, default: objNull]

    Returns:
        The conditions have been met [BOOL]
 */

params [
    ["_player", objNull, [objNull]]
];

// TODO: TBD: at the moment there is a "Build", need to verify "Logistics" permission, etc, however
/* The criteria are:
 * 1. player has either "Build" or "Logistics" permissions
 * 2. player in range of a factory sector
 *  i. which does not currently have a storage container
 * 3. there are no other players currently building in the player sector
 * 
 */

[
    KPLIB_param_sectors_capRange
    , KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor; }
] params [
    "_range"
    , "_candidateSectors"
];

private _factoryMarker = [_player, _range, _candidateSectors] call KPLIB_fnc_common_getTargetMarkerIfInRange;

private _storageContainers = nearestObjects [markerPos _factoryMarker, [KPLIB_preset_storageSmallF], _range];

// "KPLIB_build_storageFactoryMarker" indicates when a player is currently building in the sector
private _otherPlayersCurrentlyBuilding = allPlayers select {
    !(_x isEqualTo _player);
} select {
    (_x getVariable ["KPLIB_build_storageFactoryMarker", ""]) isEqualTo _factoryMarker;
};

private _permissions = ["Build", "Logistics"] apply { [_x] call KPLIB_fnc_permission_checkPermission; };

_storageContainers isEqualTo []
    && !(
        isNull _player
        || _permissions isEqualTo []
        || _factoryMarker isEqualTo ""
    )
    && _otherPlayersCurrentlyBuilding isEqualTo []
    ;
