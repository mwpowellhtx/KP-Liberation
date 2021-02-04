/*
    KPLIB_fnc_build_handleFobBuildConfirm

    File: fn_build_handleFobBuildConfirm.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-29
    Last Update: 2021-01-27 22:10:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles FOB build confirmation

    Parameters:
        _fobBuilding - Building on which FOB will be created [OBJECT, default: objNull]
        _fobBoxObject - Object from which FOB build orignated [OBJECT, default: objNull]

    Returns:
        Confirmation was handled [BOOL]
*/

params [
    ["_fobBuilding", objNull, [objNull]],
    ["_fobBoxObject", objNull, [objNull]]
];

// TODO: TBD: this needs to be generalized a bit...
// TODO: TBD: can apply not only for FOB, but also for factory storage, for instance...
if (KPLIB_param_builddebug) then {
    [format ["[fn_build_handleFobBuildConfirm] Entering: [isNull _fobBuilding, isNull _fobBoxObject]: %1"
        , str [isNull _fobBuilding, isNull _fobBoxObject]], "BUILD"] call KPLIB_fnc_common_log;
};

if (isNull _fobBuilding) exitWith {
    ["[fn_build_handleFobBuildConfirm] Unable to create FOB", "BUILD"] call KPLIB_fnc_common_log;
};

// TODO: TBD: with the idea we string together some events here, we think...
// TODO: TBD: that we can either respond to, or not...

// Create a FOB on the position of the building, yields the FOB tuple itself
private _fob = [getPos _fobBuilding] call KPLIB_fnc_core_buildFob;

if (isNull _fobBuilding) exitWith {
    [_fob#0#3, _fob#1#2, _fob#1#3] params ["_pos", "_est", "_uuid"];
    [[_est] call KPLIB_fnc_time_formatSystemTime, mapGridPosition _pos] params ["_timestamp", "_gref"];
    [format ['FOB "%1" established %2 at grid ref %3', _uuid, _timestamp, _gref], "BUILD"] call KPLIB_fnc_common_log;
    false
};

// Emit the built event with FOB and object to assign the object to freshly built FOB
["KPLIB_build_item_built", [_fobBuilding, (_fob#0#0)]] call CBA_fnc_globalEvent;

// Remove FOB box from which FOB build originated
deleteVehicle _fobBoxObject;

true
