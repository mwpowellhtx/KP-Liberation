/*
    KPLIB_fnc_captive_addCaptiveAction

    File: fn_captive_addCaptiveAction.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-11
    Last Update: 2021-06-14 17:19:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds all needed actions to a surrendered unit.

    Parameter(s):
        _unit - Unit to apply the actions [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    ["_unit", objNull, [objNull]]
];

// Exit on missing object
if (isNull _unit) exitWith { false; };

// TODO: TBD: only when "ace not enabled" (?)
// TODO: TBD: no, we think that the action menu should be there regardless
if (!(KPLIB_ace_enabled)) then {

    // Add arrest action
    [
        _unit
        , [
            "STR_KPLIB_ACTION_ARREST"
            , { _this call KPLIB_fnc_captive_setCaptive; }
            , []
            , -800
            , false
            , true
            , ""
            , "
                ('kplib_surrender' in allVariables _target)
                    && !('kplib_captured' in allVariables _target)
            "
            , 10
        ]
        , [["_formatArgs", [name _unit]]]
    ] call KPLIB_fnc_common_addAction;

    // Add escort action
    [
        _unit
        , [
            "STR_KPLIB_ACTION_ESCORT"
            , { _this call KPLIB_fnc_captive_escort; }
            , []
            , -800
            , false
            , true
            , ""
            , "
                ('kplib_captured' in allVariables _target)
                    && !(_this getVariable ['KPLIB_captive_isEscorting', false])
            "
            , 10
        ]
        , [["_formatArgs", [name _unit]]]
    ] call KPLIB_fnc_common_addAction;

    // Add move in vehicle action
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
        , [["_formatArgs", [name _unit]]]
    ] call KPLIB_fnc_common_addAction;
};

// TODO: TBD: was in the process of seriously refactoring these ...
// TODO: TBD: along which lines ought we to be using a static public variable, or the FOB location, for purposes of "captive" interrogation?
// TODO: TBD: i.e. it should be simple enough to identify the building near the pos of the FOB and return that functionally instead...
// Add interrogate action near FOB
[
    _unit
    , [
        "STR_KPLIB_ACTION_INTERROGATE"
        , { _this call KPLIB_fnc_captive_interrogate; }
        , []
        , -800
        , false
        , true
        , ""
        , "
            !(
                ('kplib_interrogated' in allVariables _target)
                    || ((nearestObjects [_target, [KPLIB_preset_fobBuildingF], 25]) isEqualTo [])
            )
        "
        , 10
    ]
    , [["_formatArgs", [name _unit]]]
] call KPLIB_fnc_common_addAction;

true;
