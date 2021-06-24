#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitGetOutVehicle

    File: fn_captives_onUnitGetOutVehicle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:23:07
    Last Update: 2021-06-18 13:16:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when a GETOUTMAN event has occurred for a transport VEHICLE. Plays
        the appropriate animation for CAPTURED UNITS only.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]
        _role - a ROLE to consider [STRING, default: '']
        _vehicle - a VEHICLE to consider [OBJECT, default: objNull]
        _turret

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_role), "", [""]]
    , [Q(_vehicle), objNull, [objNull]]
    , Q(_turret)
];

private _debug = MPARAM(_onUnitGetOutVehicle_debug)
    || (_unit getVariable [QMVAR(_onUnitGetOutVehicle_debug), false])
    || (_vehicle getVariable [QMVAR(_onUnitGetOutVehicle_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

if (!(_unit getVariable [QMVAR(_captured), false])) exitWith {
    if (_debug) then {
        // TODO: TBD: logging...
    };
    false;
};

private _dir = getDir _vehicle;
private _pos = getPos _vehicle;
private _safeRadius = [typeOf _vehicle] call KPLIB_fnc_common_vehicleSafeRadius;

private _getOutPos = _vehiclePos getPos [_safeRadius, (_dir + 180) % 360];

_unit setPos _getOutPos;

// TODO: TBD: set the UNIT position aft of the vehicle...
[_unit] call MFUNC(_playMove);

// (Re-)set the UNIT module timer upon getting out
_unit setVariable [QMVAR(_timer), [MPARAM(_captiveTimeout), true] call KPLIB_fnc_timers_create];

if (_debug) then {
    // TODO: TBD: logging...
};

true;
