/*
    KPLIB_fnc_buildClient_onBuildStorageClicked

    File: fn_buildClient_onBuildStorageClicked.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 11:47:15
    Last Update: 2021-02-15 11:47:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Build factory sector storage container action menu callback.

    Parameter(s):
        _player - the player clicking the action menu item [OBJECT, default: player]

    Returns:
        The CBA event handler has finished [BOOL]
 */

/* TODO: TBD: this is the kicking off point for the whole storage container build process...
 * Our primary goal is to stand that function up on its feet, including client and server
 * side callbacks in the whole sequence of events. Secondary to that, downstream from that
 * effort, if we can craft that sequence to more generally accommodate deploy FOB scenarios
 * at the same time, great. But not before we accomplish the storage part itself. */

params [
    ["_player", player, [objNull]]
];

[
    KPLIB_preset_storageSmallF
    , KPLIB_param_sectorCapRange
    , KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor; }
] params [
    "_className"
    , "_range"
    , "_candidateSectors"
];

// Do not need to re-ask the condition question, we are "there" now...
private _markerName = [_player, _range, _candidateSectors] call KPLIB_fnc_common_getTargetMarkerIfInRange;

/* Which is aimed at prohibiting more than one player calling up duplicate build menus,
 * an issue coming from the legacy code base, which we think can be resolved here. */

_player setVariable ["KPLIB_build_storageFactoryMarker", _markerName, true];

[(markerPos _markerName), _range, _className, {

    private _storageContainer = (_this#0);

    [_storageContainer, _markerName] remoteExec ["KPLIB_fnc_buildServer_onConfirmBuildStorage", 2];

    // Could probably run with nil but we will go empty string in this instance
    _player setVariable ["KPLIB_build_storageFactoryMarker", "", true];

}] call KPLIB_fnc_buildClient_onBuildStorageRequested;

true;
