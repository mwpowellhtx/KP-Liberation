/*
    KPLIB_fnc_captive_addCaptiveAction

    File: fn_captive_addCaptiveAction.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-11
    Last Update: 2021-04-22 15:23:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds all needed actions to a surrendered unit.

    Parameter(s):
        _unit - Unit to apply the actions [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
 */

params [
    ["_unit", objNull, [objNull]]
];

// Exit on missing object
if (isNull _unit) exitWith {
    false
};

// TODO: TBD: only when "ace not enabled" (?)
// TODO: TBD: no, we think that the action menu should be there regardless
if (!(KPLIB_ace_enabled)) then {
    // Add arrest action
    [
        _unit,
        ["STR_KPLIB_ACTION_ARREST", name _unit],
        [{[_this select 0] call KPLIB_fnc_captive_setCaptive;}, nil, -800, false, true, "", "(_target getVariable [""KPLIB_surrender"", false]) && !(_target getVariable [""KPLIB_captive"", false])", 10]
    ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _unit];

    // Add escort action
    [
        _unit,
        ["STR_KPLIB_ACTION_ESCORT", name _unit],
        [{[_this select 0, _this select 1] call KPLIB_fnc_captive_escort;}, nil, -800, false, true, "", "_target getVariable [""KPLIB_captive"", false] && !(_this getVariable [""KPLIB_captive_isEscorting"", false])", 10]
    ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _unit];

    // Add move in vehicle action
    [_unit, {
        private _id = [
            _this,
            ["STR_KPLIB_ACTION_LOADCAPTIVE", name _this],
            [{[_this select 0] call KPLIB_fnc_captive_loadCaptive;}, nil, -800, false, true, "", "_target getVariable [""KPLIB_captive"", false] && ({(_x emptyPositions ""cargo"") > 0} count (_target nearEntities [[""LandVehicle"", ""Air""], 5])) > 0", 10]
        ] call KPLIB_fnc_common_addAction;

        // Store the load action to switch the locality when escorting
        _this setVariable ["KPLIB_captive_loadID", _id];
    }] remoteExecCall ["call", 0, _unit];

};

// TODO: TBD: along which lines ought we to be using a static public variable, or the FOB location, for purposes of "captive" interrogation?
// TODO: TBD: i.e. it should be simple enough to identify the building near the pos of the FOB and return that functionally instead...
// Add interrogate action near FOB
[
    _unit,
    ["STR_KPLIB_ACTION_INTERROGATE", name _unit],
    [{[_this select 0] call KPLIB_fnc_captive_interrogate;}, nil, -800, false, true, "", "!((nearestObjects [_target ,[KPLIB_preset_fobBuildingF], 25]) isEqualTo [])", 10]
] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _unit];

true
