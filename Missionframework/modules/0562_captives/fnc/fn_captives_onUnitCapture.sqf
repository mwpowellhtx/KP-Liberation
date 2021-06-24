#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitCapture

    File: fn_captives_onUnitCapture.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:23:07
    Last Update: 2021-06-17 12:23:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when UNIT CAPTURE action has occurred.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_onUnitCapture_debug)
    || (_unit getVariable [QMVAR(_onUnitCapture_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

[QMVAR(_captured), [_unit]] call CBA_fnc_globalEvent;

if (_debug) then {
    // TODO: TBD: logging...
};

true;
