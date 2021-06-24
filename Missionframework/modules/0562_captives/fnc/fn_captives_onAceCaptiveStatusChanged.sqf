#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onAceCaptiveStatusChanged

    File: fn_captives_onAceCaptiveStatusChanged.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-11
    Last Update: 2021-06-18 14:34:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks for ACE handcuffed units and rebinds them into the Liberation captive system.

    Parameter(s):
        _unit - the UNIT to set in captive mode [OBJECT, defaults: objNull]
        _state - a STATE of captive [BOOLEAN, defaults: false]
        _reason - a REASON of the activated event [STRING, defaults: '']

    Returns:
        The event handler has finished [BOOL]

    References:
        https://ace3mod.com/wiki/framework/events-framework.html#25-captives-ace_captives
 */

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_state), false, [false]]
    , [Q(_reason), "", [""]]
];

// TODO: TBD: we could also add some convenience module ACE interaction menus
private _debug = MPARAM(_onAceCaptiveStatusChanged_debug)
    || (_unit getVariable [QMVAR(_onAceCaptiveStatusChanged_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

if (!KPLIB_ace_enabled) exitWith {
    false;
};

if (isNull _unit || !alive _unit) exitWith {
    false;
};

// Proxy in from ACE3 to KPLIB CAPTIVES module for internal bookkeeping
switch (toLower _reason) do {

    case Q(setsurrendered): {
        private _captured = _unit getVariable [Q(KPLIB_captured), false];
        // CAPTURED is gated by SURRENDERING
        { _unit setVariable _x; } forEach [
            [Q(KPLIB_surrender), _state, true]
            , [Q(KPLIB_captured), _captured && _state, true]
        ];
        [QMVAR(_surrender), [_unit]] call CBA_fnc_globalEvent;
    };

    case Q(sethandcuffed): {
        { _unit setVariable _x; } forEach [
            [Q(KPLIB_captured), _state, true]
        ];
        [QMVAR(_captured), [_unit]] call CBA_fnc_globalEvent;
    };
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
