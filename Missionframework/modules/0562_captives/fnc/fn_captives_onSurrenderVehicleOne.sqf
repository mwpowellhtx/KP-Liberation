#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSurrenderVehicleOne

    File: fn_captives_onSurrenderVehicleOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 18:34:16
    Last Update: 2021-06-16 18:34:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Surrenders ONE VEHICLE. Conditions have already been met, we are here simply
        to close the loop on the response.

    Parameter(s):
        _vehicle - a VEHICLE object to surrender [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_vehicle), objNull, [objNull]]
];

private _debug = MPARAM(_onSurrenderVehicleOne_debug)
    || (_vehicle getVariable [QMVAR(_onSurrenderVehicleOne_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// Simply disembarks the crew and marks the vehicle CAPTURED
[_vehicle] call KPLIB_fnc_common_disembarkCrew;

// TODO: TBD: raise SURRENDER event?
_vehicle setVariable [Q(KPLIB_surrender), true, true];

if (_debug) then {
    // TODO: TBD: logging...
};

true;
