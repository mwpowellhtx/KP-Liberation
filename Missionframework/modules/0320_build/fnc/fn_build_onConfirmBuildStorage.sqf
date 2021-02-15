/*
    KPLIB_fnc_build_onConfirmBuildStorage

    File: fn_build_onConfirmBuildStorage.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-29
    Last Update: 2021-02-12 10:09:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles FOB build confirmation. By the time this event handler is invoked
        '_fobBuilding' is the actual already-built FOB building object.

    Parameters:
        _fobBuilding - Building on which FOB will be created [OBJECT, default: objNull]

    Returns:
        FOB build confirmed [BOOL]
*/

// TODO: TBD: how much of which could be generalized?
private _debug = [] call KPLIB_fnc_build_debug;

params [
    ["_targetObj", objNull, [objNull]]
    , ["_referenceMarker", "", [""]]
];

// TODO: TBD: this needs to be generalized a bit...
// TODO: TBD: can apply not only for FOB, but also for factory storage, for instance...
if (_debug) then {
    [format ["[fn_build_onConfirmBuildStorage] Entering: [isNull _targetObj]: %1"
        , str [isNull _targetObj]], "BUILD"] call KPLIB_fnc_common_log;
};

if (isNull _targetObj) exitWith {
    ["[fn_build_onConfirmBuildStorage] Unable to create target object", "BUILD"] call KPLIB_fnc_common_log;
    false;
};

// TODO: TBD: this is where we can lift such things as vector up, whether the target vector up is set, i.e. align terrain, or up
// TODO: TBD: vectors and pos may be tracked during the drag handler...
if (_debug) then {
    [format ["[fn_build_onConfirmBuildStorage] [typeOf _targetObj, getPos _targetObj, vectorUp _targetObj, KPLIB_dragPos, KPLIB_dragVectorUp]: %1"
        , str [typeOf _targetObj, getPos _targetObj, vectorUp _targetObj, _targetObj getVariable ["KPLIB_dragPos", [-1, -1, -1]]
            , _targetObj getVariable ["KPLIB_dragVectorUp", [-1, -1, -1]]]], "BUILD"] call KPLIB_fnc_common_log;
};

// TODO: TBD: gotta be a better way to do this part with the FOB differences...
// TODO: TBD: maybe we attach a second or third event handler (?)

// Emit the built event with FOB and object to assign the object to freshly built FOB
["KPLIB_build_item_built", [_targetObj, (markerPos _referenceMarker)]] call CBA_fnc_globalEvent;

true;
