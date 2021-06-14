#include "script_component.hpp"
/*
    KPLIB_fnc_captive_setVehicleSurrender

    File: fn_captive_setVehicleSurrender.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 23:49:34
    Last Update: 2021-06-14 17:19:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Surrenders the VEHICLE. The crew is instructed to DISEMBARK and prohibited from
        re-entering the vehicle. The crew themselves may not surrender, which response
        is left to subsequent functions to determine.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    ["_vehicle", objNull, [objNull]]
];

// Verify that the VEHICLE is indeed a vehicle or at least that it has crew to unload
private _positions = [_vehicle, ''] call KPLIB_fnc_core_getVehiclePositions;

[
    "kplib_surrender" in allVariables _vehicle
    , _positions isEqualTo []
] params [
    "_surrendered"
    , "_canCrew"
];

// Return early if already SURRENDERED or CANNOT CREW the object
if (_surrendered || !_canCrew) exitWith { false; };

private _crew = _positions apply { _x select 0; };

// Disembark the vehicle
{ unassignVehicle _x; } forEach _crew;

// Then prohibit them from getting in
_crew allowGetIn false;

_vehicle setVariable ["KPLIB_surrender", [KPLIB_captive_surrender_timeout] call KPLIB_fnc_timers_create, true];

true;
