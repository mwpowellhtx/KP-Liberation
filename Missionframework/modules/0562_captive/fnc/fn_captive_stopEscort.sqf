/*
    KPLIB_fnc_captive_stopEscort

    File: fn_captive_stopEscort.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-21
    Last Update: 2021-05-24 14:29:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Detach a captive from the escorting player.

    Parameter(s):
        _escort - Escorting player  [OBJECT, defaults to objNull]
        _id     - ID of the action  [NUMBER, defaults to 0.068117098106117110107]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_escort", objNull, [objNull]],
    ["_id", 0.068117098106117110107, [0]]
];

// Exit on missing object
if (isNull _escort || _id isEqualTo 0.068117098106117110107) exitWith {
    false
};

// Get the captive
private _unit = _escort getVariable ["KPLIB_captive_escorting", objNull];

// Set variable on escort
_escort setVariable ["KPLIB_captive_isEscorting", false, true];
_escort setVariable ["KPLIB_captive_escorting", objNull, true];

// Detach the captive from the player
detach _unit;

// // TODO: TBD: why all the gymnastics? ... making it more complicated than it needs to be...
// // TODO: TBD: we will circle back around on CAPTIVE, etc, remediation, after wrapping up these foundation things...
// Remove the action
player removeAction _id;

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
            _target getVariable ['KPLIB_captive', false]
                && ({ (_x emptyPositions 'cargo') > 0; } count (_target nearEntities [['LandVehicle', 'Air'], 5])) > 0
        "
        , 10
    ]
    , [["_varName", "KPLIB_captive_loadID"], ["_formatArgs", [name _unit]]]
] call KPLIB_fnc_common_addAction;

true;
