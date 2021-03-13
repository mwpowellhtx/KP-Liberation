/*
    KPLIB_fnc_core_onRepackageFob

    File: fn_core_onRepackageFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 18:06:44
    Last Update: 22021-03-12 18:06:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Repackages the FOB near the target location to either BOX or TRUCK.

    Parameters:
        _player - the reference object near which to repackage the FOB [OBJECT, default: player]
        _caller - [OBJECT, default: objNull]
        _actionId - [SCALAR, default: 0]
        _args - consisting of the following [ARRAY, default: []]
            _className - the desired form factor into which to repackage [STRING, default: KPLIB_preset_fobBoxF]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_core_onRepackageFob_debug}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_player", player, [objNull]]
    , ["_caller", objNull, [objNull]]
    , ["_actionId", 0, [0]]
    , ["_args", [], [[]]]
];

private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
private _playerCount = ({ _markerName isEqualTo (_x getVariable ["KPLIB_core_repackageFobMarker", ""]); } count allPlayers);

if (_playerCount > 0) exitWith {
    // TODO: TBD: indicate a better message than this...
    // TODO: TBD: as well as some logging...
    systemChat "Repackaging already in progress...";
};

// Set the player variable ASAP in order to preclude others from doing the same
_player setVariable ["KPLIB_core_repackageFobMarker", _markerName, true];

_args params [
    ["_className", "", [""]]
];

private _range = KPLIB_param_fobRange;

if (_debug) then {
    [format ["[fn_core_onRepackageFob] Entering: [_className, _range, _markerName]: %1"
        , str [_className, _range, _markerName]], "CORE"] call KPLIB_fnc_common_log;
};

KPLIB_build_player = _player;

[(markerPos _markerName), _range, _className, {

    private _debug = [
        [
            {KPLIB_param_core_onRepackageFob_onConfirm_debug}
        ]
    ] call KPLIB_fnc_debug_debug;

    private _repackagedObj = (_this#0);

    private _markerName = KPLIB_build_player getVariable ["KPLIB_core_repackageFobMarker", ""];

    if (_debug) then {
        [format ["[fn_core_onRepackageFob::confirm] Entering: [count _this, _this, typeOf _repackagedObj, _markerName]: %1"
            , str [count _this, _this, typeOf _repackagedObj, _markerName]], "CORE"] call KPLIB_fnc_common_log;
    };

    KPLIB_build_player setVariable ["KPLIB_core_repackageFobMarker", nil, true];

    [_repackagedObj, _markerName] remoteExec ["KPLIB_fnc_core_onConfirmRepackageFob", 2];

    KPLIB_build_player = nil;

}] call KPLIB_fnc_buildClient_onBuildStorageRequested;

true;
