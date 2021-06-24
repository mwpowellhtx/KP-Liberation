#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitLoad

    File: fn_captives_onUnitLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:23:07
    Last Update: 2021-06-17 12:23:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...


        // Responds when UNIT LOAD action has occurred.

        // We expect that the callbacks used during the ACTION CONDITION should install
        // a 'KPLIB_captives_transport' variable on the ESCORT object when the appropriate
        // transport VEHICLE is evaluated. Note that the primary response ought to be
        // either an OBJECT, against which NULL may be verified, or an actual BOOL, which
        // contributes to the overall CONDITION itself. However, the variable is also one
        // expected side effect that should occur.

        // The side effect of this functional callback is to clear that variable once
        // the LOAD transfer has been fully evaluated.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/addAction#Syntax_3
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _escort = attachedTo _unit;

private _debug = MPARAM(_onUnitLoad_debug)
    || (_unit getVariable [QMVAR(_onUnitLoad_debug), false])
    || (_escort getVariable [QMVAR(_onUnitLoad_debug), false])
    ;

if (_debug) then {
    [format ["[fn_captives_onUnitLoad] Entering: [name _unit]: %1"
        , str [name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

if (isNull _unit && !alive _unit) exitWith {
    false;
};

// Allowing the module WATCH service to clean up orphaned or ghosted ESCORTS
if (!isNull _escort) then {

    if (_debug) then {
        [format ["[fn_captives_onUnitLoad] Detaching: [name _unit, name _escort]: %1"
            , str [name _unit, name _escort]], "CAPTIVES", true] call KPLIB_fnc_common_log;
    };

    detach _unit;
};

// This is the single point of contact connecting UNIT+VEHICLE
private _vehicle = _unit getVariable [QMVAR(_transport), objNull];

_unit setVariable [QMVAR(_transport), nil];

// Emit target event to move the unit into the vehicle
if (!isNull _vehicle) then {
    [QMVAR(_load), [_unit, _vehicle]] call CBA_fnc_serverEvent;
};

if (_debug) then {
    ["[fn_captives_onUnitLoad] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
