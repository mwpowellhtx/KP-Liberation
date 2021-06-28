#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onVehicleCreated

    File: fn_captives_onVehicleCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 13:15:11
    Last Update: 2021-06-27 16:27:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges GETIN event handling in a remotely invoked manner.

    Parameter(s):
        _object - an OBjECT that was created [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://github.com/CBATeam/CBA_A3/blob/master/addons/events/fnc_addBISEventHandler.sqf#L54
 */

params [
    [Q(_object), objNull, [objNull]]
];

private _debug = MPARAM(_onVehicleCreated_debug)
    || (_object getVariable [QMVAR(_onVehicleCreated_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// Report the positions regardless of their occupancy, in which case, wire the bits in a JIP
private _includeEmpty = true;
if (([_object, Q(cargo), _includeEmpty] call KPLIB_fnc_core_getVehiclePositions) isNotEqualTo []) then {
    [_object] remoteExecCall [QMFUNC(_addVehicleActions), 0, _object];
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
