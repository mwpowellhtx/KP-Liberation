/*
    KPLIB_fnc_build_onBuildStorageClicked

    File: fn_build_onBuildStorageClicked.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 11:47:15
    Last Update: 2021-05-22 15:10:38
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

private _debug = KPLIB_param_build_onBuildStorageClicked_debug
    || (_player getVariable ["KPLIB_build_onBuildStorageClicked_debug", false]);

// If we are here it is because the action conditions allowed it
private _markerName = _player getVariable ["KPLIB_sectors_markerName", ""];

if (_debug) then {
    [format ["[fn_buildClient_onBuildStorageClicked] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "BUILD"] call KPLIB_fnc_common_log;
};

// Prohibit other players from entering the build mode once this player does
_player setVariable ["KPLIB_build_markerName", _markerName, true];

[markerPos _markerName, KPLIB_param_sectors_capRange, [KPLIB_preset_storageSmallF, 0, 0, 0]] call KPLIB_fnc_build_start_single;

if (_debug) then {
    [format ["[fn_buildClient_onBuildStorageClicked] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "BUILD"] call KPLIB_fnc_common_log;
};

true;
