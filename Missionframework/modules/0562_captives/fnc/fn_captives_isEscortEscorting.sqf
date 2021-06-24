#include "script_component.hpp"
/*
    KPLIB_fnc_captives_isEscortEscorting

    File: fn_captives_isEscortEscorting.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-20 14:29:26
    Last Update: 2021-06-20 14:29:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the ESCORT IS ESCORTING.

    Parameter(s):
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        Whether the ESCORT IS in fact ESCORTING [BOOL]
 */

params [
    [Q(_escort), objNull, [objNull]]
];

private _debug = MPARAM(_isEscortEscorting_debug)
    || (_escort getVariable [QMVAR(_isEscortEscorting_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _escorting = [
    _escort getVariable [QMVAR(_isEscorting), false]
    , _escort getVariable [Q(ace_captives_isEscorting), false]
] select KPLIB_ace_enabled;

if (_debug) then {
    // TODO: TBD: logging...
};

_escorting;
