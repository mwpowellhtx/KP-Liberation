#include "script_component.hpp"
/*
    KPLIB_fnc_captives_isUnitInterrogated

    File: fn_captives_isUnitInterrogated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-20 14:45:19
    Last Update: 2021-06-20 14:45:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the UNIT IS considered INTERROGATED.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        Whether the UNIT IS in fact INTERROGATED [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_isUnitInterrogated_debug)
    || (_unit getVariable [QMVAR(_isUnitInterrogated_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _interrogated = _unit getVariable [Q(KPLIB_interrogated), false];

if (_debug) then {
    // TODO: TBD: logging...
};

_interrogated;
