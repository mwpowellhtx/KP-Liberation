#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitToggleEscort

    File: fn_captives_onUnitToggleEscort.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:23:07
    Last Update: 2021-06-17 12:23:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when UNIT ESCORT action has occurred. Handles both cases when the
        TARGET UNIT to be ESCORTED, as well as when the same is to be STOP ESCORTING.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/attachedTo
        https://community.bistudio.com/wiki/attachTo
        https://community.bistudio.com/wiki/detach
        https://community.bistudio.com/wiki/setUserActionText
 */

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_escort), objNull, [objNull]]
];

private _debug = MPARAM(_onUnitToggleEscort_debug)
    || (_unit getVariable [QMVAR(_onUnitToggleEscort_debug), false])
    || (_escort getVariable [QMVAR(_onUnitToggleEscort_debug), false])
    ;

if (_debug) then {
    [format ["[fn_captives_onUnitToggleEscort] Entering: [name _escort, name _unit]: %1"
        , str [name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

// Conditions should properly direct the scenarios however ESCORT still should not be NULL
if (isNull _escort) exitWith {
    false;
};

switch (true) do {

    // In this case, attaching the UNIT to the ESCORT
    case (isNull attachedTo _unit): {

        if (_debug) then {
            // TODO: TBD: logging...
        };

        [_escort] call MFUNC(_onWatchStopEscortingOne);

        _unit attachTo [_escort, MPRESET(_escortOffset)];

        { _escort setVariable _x; } forEach [
            [QMVAR(_escortedUnit), _unit, true]
            , [QMVAR(_isEscorting), true, true]
        ];

        [_escort] call MFUNC(_addEscortActions);

        // Disable the timer from running during the escort
        _unit setVariable [QMVAR(_timer), [], true];
    };

    // Expecting ESCORT as an ATTACHEDTO handshake
    case (attachedTo _unit isEqualTo _escort): {

        if (_debug) then {
            // TODO: TBD: logging...
        };

        // Which ESCORT shall no longer be ATTACHEDTO UNIT, so 'STOP'
        detach _unit;

        [_escort] call MFUNC(_onWatchStopEscortingOne);

        // (Re-)start the module TIMER accodingly
        _unit setVariable [QMVAR(_timer), [MPARAM(_captiveTimeout)] call KPLIB_fnc_timers_create, true];
    };
};

if (_debug) then {
    ["[fn_captives_onUnitToggleEscort] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

false;
