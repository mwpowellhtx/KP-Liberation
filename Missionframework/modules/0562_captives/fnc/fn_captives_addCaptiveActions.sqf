#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_captives_addCaptiveActions

    File: fn_captives_addCaptiveActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:18:24
    Last Update: 2021-06-27 16:35:01
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

if (hasInterface && !KPLIB_ace_enabled) then {
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
            , '
                (alive _target)
                    && (_target getVariable ["KPLIB_surrender", false])
                    && !(_target getVariable ["KPLIB_captured", false])
            '
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
            , '
                (alive _target)
                    && (_target getVariable ["KPLIB_captured", false])
                    && (isNull objectParent _target)
                    && !(_this getVariable ["KPLIB_captives_isEscorting", false])
            '
            , MPRESET(_actionRange)
        ]
        , [
            [Q(_varName), QMVAR(_escortID)]
            , [Q(_formatArgs), [name _unit]]
        ]
    ] call KPLIB_fnc_common_addAction;

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
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
