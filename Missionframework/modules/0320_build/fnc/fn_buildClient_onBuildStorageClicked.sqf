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

private _debug = [] call KPLIB_fnc_build_debug;

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

if (_debug) then {
    [format ["[fn_buildClient_onBuildStorageClicked] Entering: [_className, _range, _markerName, _candidateSectors]: %1"
        , str [_className, _range, _markerName, _candidateSectors]], "BUILD"] call KPLIB_fnc_common_log;
};

/* Which is aimed at prohibiting more than one player calling up duplicate build menus,
 * an issue coming from the legacy code base, which we think can be resolved here. */

_player setVariable ["KPLIB_build_storageFactoryMarker", _markerName, true];

// TODO: TBD: not sure how else we can get it in there...
// TODO: TBD: we are losing scope and therefore any local locals vanish in the process...
// TODO: TBD: if we could somehow convey proper remoteExec, or CBA server event, args, that might work better...
// TODO: TBD: but that would also mean reworking the entire build scaffold dealing in remotes...
KPLIB_build_player = _player;

[(markerPos _markerName), _range, _className, {

    private _debug = [] call KPLIB_fnc_build_debug;

    private _storageContainer = (_this#0);
    private _markerName = KPLIB_build_player getVariable ["KPLIB_build_storageFactoryMarker", ""];

    if (_debug) then {
        [format ["[fn_buildClient_onBuildStorageClicked::confirm] Entering: [count _this, _this, typeOf _storageContainer, _markerName]: %1"
            , str [count _this, _this, typeOf _storageContainer, _markerName]], "BUILD"] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: it is critical that the variable be set...
    // TODO: TBD: but it is equally important, we think, for the code to be more easily maintainable...
    // TODO: TBD: and therefore the factoring to be sound...
    // TODO: TBD: this may be the best possible placement for a set such as this...
    // TODO: TBD: contrast that with a 'KPLIB_build_item_built' placement, let's say...
    _storageContainer setVariable ["KPLIB_sector_markerName", _markerName, true];

    // Could probably run with nil but we will go empty string in this instance
    KPLIB_build_player setVariable ["KPLIB_build_storageFactoryMarker", "", true];

    [_storageContainer, _markerName] remoteExec ["KPLIB_fnc_buildServer_onConfirmBuildStorage", 2];

    KPLIB_build_player = nil;

}] call KPLIB_fnc_buildClient_onBuildStorageRequested;

true;
