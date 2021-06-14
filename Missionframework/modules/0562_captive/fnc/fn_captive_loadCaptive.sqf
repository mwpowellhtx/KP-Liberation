/*
    KPLIB_fnc_captive_loadCaptive

    File: fn_captive_loadCaptive.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-22
    Last Update: I
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads given unit into the nearest vehicle cargo seat.

    Parameter(s):
        _unit - Unit to load in vehicle [OBJECT, defaults to objNull]

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

// Get the nearest vehicle
private _vehicle = ((_unit nearEntities [["LandVehicle", "Air"], 5]) select {(_x emptyPositions "cargo") > 0}) select 0;

// Check if the unit is getting escorted
if !(isNull attachedTo _unit) then {
    detach _unit;

    // Set variable on escorting unit
    player setVariable ["KPLIB_captive_isEscorting", false, true];
    player setVariable ["KPLIB_captive_escorting", objNull, true];

    // Switch the load action from player to unitAddons
    player removeAction (_unit getVariable ["KPLIB_captive_loadID", 9000]);

    [
        _unit
        , [
            "STR_KPLIB_ACTION_LOADCAPTIVE"
            , { _this call KPLIB_fnc_captive_loadCaptive; }
            , []
            , -800
            , false
            , true
            , ""
            , "
                ('kplib_captured' in allVariables _target)
                    && ({ (_x emptyPositions 'cargo') > 0; } count (_target nearEntities [['LandVehicle', 'Air'], 5])) > 0
            "
            , 10
        ]
        , [["_varName", "KPLIB_captive_loadID"], ["_formatArgs", [name _unit]]]
    ] call KPLIB_fnc_common_addAction;
};

// Emit target event to move the unit into the vehicle
["KPLIB_captive_load", [_unit, _vehicle], _unit] call CBA_fnc_targetEvent;

// Emit global event
["KPLIB_captive_loaded", [_unit, _vehicle]] call CBA_fnc_globalEvent;

true;
