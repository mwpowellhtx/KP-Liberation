#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitGetInVehicle

    File: fn_captives_onUnitGetInVehicle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-18 20:07:17
    Last Update: 2021-06-18 20:07:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when a GETINMAN event has occurred for a transport VEHICLE.
        For now this is a no-op, but the placeholder is here in the event we
        need to fill any gaps.

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

private _debug = MPARAM(_onUnitGetInVehicle_debug)
    || (_unit getVariable [QMVAR(_onUnitGetInVehicle_debug), false])
    || (_vehicle getVariable [QMVAR(_onUnitGetInVehicle_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// For the moment there is nothing to do here.

if (_debug) then {
    // TODO: TBD: logging...
};

true;
