#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_captives_addEscortActions

    File: fn_captives_addEscortActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-22 15:48:18
    Last Update: 2021-06-22 15:48:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        // Adds the CAPTIVES module actions to the UNIT. We will go ahead and simply add the
        // bits on the UNIT object that need to be there now so we do not worry about it later.
        // Actions include, CAPTURE, LOAD, maybe UNLOAD, etc.

    Parameter(s):
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_escort), objNull, [objNull]]
];

private _unit = _escort getVariable [QMVAR(_escortedUnit), objNull];

private _debug = MPARAM(_addEscortActions_debug)
    || (_unit getVariable [QMVAR(_addEscortActions_debug), false])
    || (_escort getVariable [QMVAR(_addEscortActions_debug), false])
    ;

if (_debug) then {
    [format ["[fn_captives_addEscortActions] Entering: [name _escort, name _unit]: %1"
        , str [name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

if (hasInterface && !KPLIB_ace_enabled) then {

    [
        [
            "STR_KPLIB_ACTIONS_CAPTIVES_LOAD_FORMAT"
            , {
                params [Q(_escort)];
                [_escort getVariable [QMVAR(_escortedUnit), objNull], _escort] call MFUNC(_onUnitLoad);
            }
            , []
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , true
            , true
            , ""
            , '[_target getVariable ["KPLIB_captives_escortedUnit", objNull], _target] call KPLIB_fnc_captives_canLoadUnit'
            , -1
        ]
        , [
            [Q(_varName), QMVAR(_loadUnitID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "STR_KPLIB_ACTIONS_CAPTIVES_STOP_ESCORT_FORMAT"
            , {
                params [Q(_escort)];
                private _unit = _escort getVariable [QMVAR(_escortedUnit), objNull];
                [_unit, _escort] call MFUNC(_onUnitToggleEscort);
            }
            , []
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , true
            , true
            , ""
            , "
                _target getVariable ['KPLIB_captives_isEscorting', false]
                    && alive (_target getVariable ['KPLIB_captives_escortedUnit', objNull])
                    && attachedTo (_target getVariable ['KPLIB_captives_escortedUnit', objNull]) isEqualTo _target
            "
            , -1
        ]
        , [
            [Q(_varName), QMVAR(_stopEscortingID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addPlayerAction;
};

if (_debug) then {
    ["[fn_captives_addEscortActions] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
