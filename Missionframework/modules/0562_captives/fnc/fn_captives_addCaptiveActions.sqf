#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_captives_addCaptiveActions

    File: fn_captives_addCaptiveActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:18:24
    Last Update: 2021-06-17 12:18:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds the CAPTIVES module actions to the UNIT. We will go ahead and simply add the
        bits on the UNIT object that need to be there now so we do not worry about it later.
        Actions include, CAPTURE, LOAD, maybe UNLOAD, etc.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        Whether the UNIT is SURRENDERED [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetIn
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_addCaptiveActions_debug)
    || (_unit getVariable [QMVAR(_addCaptiveActions_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// // TODO: TBD: installed on vehicle actions instead
// if (isServer) then {
//     /* The event handler connects the dots when the UNIT actually "moves in" to a target
//      * VEHICLE. The action instructing the UNIT to actually "movein" to the VEHICLE is
//      * another matter entirely.
//      */
//     if ((_unit getVariable [QMVAR(_getInID), -1]) < 0) then {
//         private _getInID = [_unit, Q(GetIn), {
//                 _this call MFUNC(_onUnitGetInVehicle);
//             }] call CBA_fnc_addBISEventHandler;
//         _unit setVariable [QMVAR(_getInID), _getInID];
//     };
// };

if (hasInterface && !KPLIB_ace_enabled) then {

    // TODO: TBD: may want to add actions or not depending on 'KPLIB_ace_enabled'
    [
        _unit
        , [
            "STR_KPLIB_ACTIONS_CAPTIVES_CAPTURE_FORMAT"
            , { _this call MFUNC(_onUnitCapture); }
            , []
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , true
            , true
            , ""
            , "
                (alive _target)
                    && (_target getVariable ['KPLIB_surrender', false])
                    && !(_target getVariable ['KPLIB_captured', false])
            "
            , MPRESET(_actionRange)
        ]
        , [
            [Q(_varName), QMVAR(_captureID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addAction;

    [
        _unit
        , [
            "STR_KPLIB_ACTIONS_CAPTIVES_ESCORT_FORMAT"
            , { _this call MFUNC(_onUnitToggleEscort); }
            , []
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , true
            , true
            , ""
            , "
                (alive _target)
                    && (_target getVariable ['KPLIB_captured', false])
                    && (isNull objectParent _target)
                    && !(_this getVariable ['KPLIB_captives_isEscorting', false])
            "
            , MPRESET(_actionRange)
        ]
        , [
            [Q(_varName), QMVAR(_escortID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addAction;

    // TODO: TBD: is an escort action and/or vehicle action...

    // TODO: TBD: may want to consider ESCORT ACTIONS...
    // TODO: TBD: i.e. for the load scenario in which player looks at transport, cursortarget
    [
        _unit
        , [
            "STR_KPLIB_ACTIONS_CAPTIVES_LOAD_FORMAT"
            , {
                params [Q(_unit), Q(_escort)];
                [_unit, _escort] call MFUNC(_onUnitLoad);
            }
            , []
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , true
            , true
            , ""
            , "[_target, _this, true] call KPLIB_fnc_captives_canLoadUnit"
            , MPRESET(_actionRange)
        ]
        , [
            [Q(_varName), QMVAR(_loadUnitID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addAction;

    // [
    //     [
    //         "STR_KPLIB_ACTIONS_CAPTIVES_STOP_ESCORT_FORMAT"
    //         , {
    //             params [Q(_escort)];
    //             [_escort getVariable [QMVAR(_escortedUnit), objNull], _escort] call MFUNC(_onUnitToggleEscort);
    //         }
    //         , []
    //         , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
    //         , true
    //         , true
    //         , ""
    //         , "
    //             _target getVariable ['KPLIB_captives_isEscorting', false]
    //                 && alive (_target getVariable ['KPLIB_captives_escortedUnit', objNull])
    //                 && attachedTo (_target getVariable ['KPLIB_captives_escortedUnit', objNull]) isEqualTo _target
    //         "
    //         // // TODO: TBD: conditions when the action was UNIT centric...
    //         // , "
    //         //     (alive _target)
    //         //         && (_target getVariable ['KPLIB_captured', false])
    //         //         && (attachedTo _target isEqualTo _this)
    //         //         && (_target isEqualTo (_this getVariable ['KPLIB_captives_escortedUnit', objNull]))
    //         // "
    //         , -1
    //     ]
    //     , [
    //         [Q(_varName), QMVAR(_stopEscortingID)]
    //         , [Q(_formatArgs), [name _unit]]
    //     ]
    // ] call KPLIB_fnc_common_addPlayerAction;
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
