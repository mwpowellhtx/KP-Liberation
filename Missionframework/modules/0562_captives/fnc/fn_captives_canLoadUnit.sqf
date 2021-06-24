#include "script_component.hpp"
/*
    KPLIB_fnc_captives_canLoadUnit

    File: fn_captives_canLoadUnit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-23 08:45:13
    Last Update: 2021-06-23 08:45:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        Whether the ESCORT CAN LOAD the UNIT onto a nearby TRANSPORT VEHICLE [BOOL]

    References:
        https://community.bistudio.com/wiki/fullCrew
 */

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_escort), objNull, [objNull]]
    , [Q(_captive), false, [false]]
];

private _debug = MPARAM(_canLoadUnit_debug)
    || (_unit getVariable [QMVAR(_canLoadUnit_debug), false])
    || (_escort getVariable [QMVAR(_canLoadUnit_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _escortedUnit = _escort getVariable [QMVAR(_escortedUnit), objNull];

private _alive = alive _unit;
private _captured = _unit getVariable [Q(KPLIB_captured), false];
private _vehicle = [_unit] call MFUNC(_getNearestTransport);

if (_debug) then {
    // TODO: TBD: logging...
};

private _baseCond = _alive
    && _captured
    && !isNull _vehicle
    && isNull objectParent _unit
    ;

private _isUnitAttachedToEscort = attachedTo _unit isEqualTo _escort;

if (_debug) then {
    // TODO: TBD: logging...
};

private _captiveCond = _captive && !_isUnitAttachedToEscort;

private _escorting = _escort getVariable [QMVAR(_isEscorting), false];

if (_debug) then {
    // TODO: TBD: logging...
};

private _escortCond = !_captive && _escorting && _isUnitAttachedToEscort;

if (_debug) then {
    // TODO: TBD: logging...
};

_baseCond && (_captiveCond || _escortCond);
