/*
    KPLIB_fnc_core_canBuildFob

    File: fn_core_canBuildFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-11
    Last Update: 2021-01-27 14:22:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Checks if player can build FOB from box.

    Parameter(s):
        _box - FOB box [OBJECT, default: objNull]
        _player - Player trying to build FOB [OBJECT, default: objNull]

    Returns:
        True if box is spawned [BOOL]
*/

private _debug = false && ([] call KPLIB_fnc_build_debug);

params [
    ["_box", objNull, [objNull]]
    , ["_player", objNull, [objNull]]
];

// Built FOB range should not overlap over sector range
private _minSectorDist = KPLIB_param_fobRange + KPLIB_param_sectorCapRange;

if (_debug) then {
    [format ["[fn_core_canBuildFob] Entering: [isNull _box, typeOf _box, typeOf _player, isNil 'KPLIB_fnc_eden_callback_onWithinRange', KPLIB_param_fobRange, KPLIB_param_sectorCapRange]: %1"
        , str [isNull _box, typeOf _box, typeOf _player, isNil 'KPLIB_fnc_eden_callback_onWithinRange', KPLIB_param_fobRange, KPLIB_param_sectorCapRange]], "BUILD", true] call KPLIB_fnc_common_log;
};

(
    alive _box
    // TODO: TBD: potential gap between initiating the build procedure, and an actual FOB location having been selected...
    // TODO: TBD: we should be aware of this in the build chain of events and perhaps address it there instead...
    // TODO: TBD: also not sure I like the approach on the functions...
    // TODO: TBD: could see about leveraging primitives, i.e. count predicates, more frequently, for instance...
    && ([_box, KPLIB_fnc_eden_callback_onWithinRange] call KPLIB_fnc_eden_select) isEqualTo []
    // TODO: TBD: probably could use a similar "selectFob" or generally "select sector" ...
    && (KPLIB_sectors_fobs select {(_x#0#3) distance2D _box <= _minSectorDist}) isEqualTo []
    //                   1. _pos:   ^^^^^^
    // TODO: TBD: same exercise we have for the FOB tuples...
    // TODO: TBD: will need to rinse and repeat for the sectors establishing a bit more in depth tuple...
    && ([_minSectorDist, getPos _box, KPLIB_sectors_all] call KPLIB_fnc_core_getNearestMarker isEqualTo "")
)
