#include "script_component.hpp"
/*
    KPLIB_fnc_captives_isUnitSurrendering

    File: fn_captives_isUnitSurrendering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-20 14:45:19
    Last Update: 2021-06-20 14:45:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the UNIT can be considered IS SURRENDERING.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        Whether the UNIT IS in fact SURRENDERING [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_isUnitSurrendering_debug)
    || (_unit getVariable [QMVAR(_isUnitSurrendering_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _whereTrue = { _unit getVariable [_x, false]; };

private _surrenderingCount = [
    _whereTrue count [Q(KPLIB_surrender), Q(KPLIB_captured)]
    , _whereTrue count [Q(ace_captives_isSurrendering), Q(ace_captives_isHandcuffed)]
] select KPLIB_ace_enabled;

if (_debug) then {
    // TODO: TBD: logging...
};

_surrenderingCount > 0;
