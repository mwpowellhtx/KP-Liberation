/*
    KPLIB_fnc_build_onConfirmBuildFob

    File: fn_build_onConfirmBuildFob.sqf
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
        _fobBoxObject - Object from which FOB build orignated [OBJECT, default: objNull]

    Returns:
        FOB build confirmed [BOOL]
*/

private _debug = [] call KPLIB_fnc_build_debug;

params [
    ["_fobBuilding", objNull, [objNull]],
    ["_fobBoxObject", objNull, [objNull]]
];

// TODO: TBD: this needs to be generalized a bit...
// TODO: TBD: can apply not only for FOB, but also for factory storage, for instance...
if (_debug) then {
    [format ["[fn_build_onConfirmBuildFob] Entering: [isNull _fobBuilding, isNull _fobBoxObject]: %1"
        , str [isNull _fobBuilding, isNull _fobBoxObject]], "BUILD"] call KPLIB_fnc_common_log;
};

if (isNull _fobBuilding) exitWith {
    ["[fn_build_onConfirmBuildFob] Unable to create FOB", "BUILD"] call KPLIB_fnc_common_log;
    false;
};

// TODO: TBD: vectors and pos may be tracked during the drag handler...
if (_debug) then {
    [format ["[fn_build_onConfirmBuildFob] [typeOf _fobBuilding, getPos _fobBuilding, vectorUp _fobBuilding, KPLIB_dragPos, KPLIB_dragVectorUp]: %1"
        , str [typeOf _fobBuilding, getPos _fobBuilding, vectorUp _fobBuilding, _fobBuilding getVariable ["KPLIB_dragPos", [-1, -1, -1]]
            , _fobBuilding getVariable ["KPLIB_dragVectorUp", [-1, -1, -1]]]], "BUILD"] call KPLIB_fnc_common_log;
};

// TODO: TBD: with the idea we string together some events here, we think...
// TODO: TBD: that we can either respond to, or not...

// Create a FOB on the position of the building, yields the FOB tuple itself
private _fob = [getPos _fobBuilding] call KPLIB_fnc_core_buildFob;

if (isNull _fobBuilding) exitWith {
    // Minding our 'KPLIB_sectors_fobs' tuples...
    [_fob#3, _fob#4, _fob#5] params ["_uuid", "_pos", "_est"];
    [[_est] call KPLIB_fnc_time_formatSystemTime, mapGridPosition _pos] params ["_timestamp", "_gref"];
    [format ['FOB "%1" established %2 at grid ref %3', _uuid, _timestamp, _gref], "BUILD"] call KPLIB_fnc_common_log;
    false;
};

// Emit the built event with FOB and object to assign the object to freshly built FOB
["KPLIB_build_item_built", [_fobBuilding, (_fob#0)]] call CBA_fnc_globalEvent;
//                        1. _markerName:  ^^^^^^

// Remove FOB box from which FOB build originated
deleteVehicle _fobBoxObject;

true;
