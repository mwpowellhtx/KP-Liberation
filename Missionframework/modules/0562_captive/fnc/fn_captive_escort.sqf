/*
    KPLIB_fnc_captive_escort

    File: fn_captive_escort.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-21
    Last Update: 2021-05-24 14:39:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Attach a captive to the escorting player.

    Parameter(s):
        _unit       - Unit which will be escorted   [OBJECT, defaults to objNull]
        _escort     - Escorting player              [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_unit", objNull, [objNull]],
    ["_escort", objNull, [objNull]]
];

// Exit on missing object
if (isNull _unit || isNull _escort) exitWith {
    false
};

// Set variable on escort
_escort setVariable ["KPLIB_captive_isEscorting", true, true];
_escort setVariable ["KPLIB_captive_escorting", _unit, true];

// Attach the captive to the player
_unit attachTo [_escort, [0, 1, 0]];

// Switch the load action from unit to player
_unit removeAction (_unit getVariable ["KPLIB_captive_loadID", 9000]);

// TODO: TBD: targets, etc, need to be reconsidered
private _id = [
    _escort
    , [
        "STR_KPLIB_ACTION_LOADCAPTIVE"
        , { [_this#3] call KPLIB_fnc_captive_loadCaptive; }
        , _unit
        , -800
        , false
        , true
        , ""
        , "
            ({ (_x emptyPositions 'cargo') > 0; } count (_target nearEntities [['LandVehicle', 'Air'], 5])) > 0
        "
        , 10
    ]
    , [["_formatArgs", [name _unit]]]
] call KPLIB_fnc_common_addAction;

// TODO: TBD: not least of which the confusion here among actions, ids, cross-object variables, etc...
_unit setVariable ["KPLIB_captive_loadID", _id];

// Add the action to release the captive
_id = [
    _escort
    , [
        "STR_KPLIB_ACTION_STOPESCORT"
        , { [_this#0, _this#2] call KPLIB_fnc_captive_stopEscort; }
        , []
        , -800
        , false
        , true
        , ""
        , ""
        , 10
    ]
    , [["_formatArgs", [name _unit]], ["_varName", "KPLIB_stopEscort_id"]]
] call KPLIB_fnc_common_addAction;

true;
