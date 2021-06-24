#include "script_component.hpp"
/*
    KPLIB_fnc_captives_getEscortedUnit

    File: fn_captives_getEscortedUnit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-20 14:26:03
    Last Update: 2021-06-20 14:26:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ESCORTED UNIT from the ESCORT.

    Parameter(s):
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        The ESCORTED UNIT if available [OBJECT, default: objNull]
 */

params [
    [Q(_escort), objNull, [objNull]]
];

private _debug = MPARAM(_getEscortedUnit_debug)
    || (_escort getVariable [QMVAR(_getEscortedUnit_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _unit = [
    _escort getVariable [QMVAR(_escortedUnit), objNull]
    , _escort getVariable [Q(ace_captives_escortedUnit), objNull]
] select KPLIB_ace_enabled;

if (_debug) then {
    // TODO: TBD: logging...
};

_unit;
