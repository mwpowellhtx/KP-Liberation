#include "script_component.hpp"
/*
    KPLIB_fnc_captives_getNearestTransport

    File: fn_captives_getNearestTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 19:16:39
    Last Update: 2021-06-17 19:16:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the NEAREST TRANSPORT which can receive the CAPTURED UNIT if available.
        Returns OBJNULL otherwise.

    Parameter(s):
        _unit - a CAPTURED UNIT to consider [OBJECT, default: objNull]
        _range

    Returns:
        A nearest VEHICLE to the CAPTURED UNIT that can LOAD an escorted unit [OBJECT]

    References:
        https://community.bistudio.com/wiki/cursorTarget
        https://community.bistudio.com/wiki/nearestObjects
 */

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_range), MPARAM(_loadRange), [0]]
];

private _debug = MPARAM(_getNearestTransport_debug)
    || (_unit getVariable [QMVAR(_getNearestTransport_debug), false])
    ;

private _allTransports = nearestObjects [_unit, MPRESET(_transportTypes), _range];

private _transports = [
    _allTransports
    , []
    , { _x distance _unit; }
    , Q(ascend)
    , { [_x, _unit] call MFUNC(_canLoadTransport); }
] call BIS_fnc_sortBy;

_transports params [
    [Q(_transport), objNull, [objNull]]
];

// We also set the 'KPLIB_captives_transport' variable on the ESCORT as later reference
_unit setVariable [QMVAR(_transport), _transport];

_transport;
