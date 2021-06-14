/*
    KPLIB_fnc_common_disembarkCrew

    File: fn_common_disembarkCrew.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-13 10:19:04
    Last Update: 2021-06-14 16:38:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Disembarks the crew from the target object, assuming it was a vehicle.

    Parameter(s):
        _target - a target object [OBJECT, default: objNull]

    Returns:
        The target object [OBJECT]
*/

params [
    ["_target", objNull, [objNull]]
];

if (!([_target] call KPLIB_fnc_common_isVehicle)) exitWith {
    false;
};

// Boot any occupants from the now dead vehicle if they were not already ejected
private _crew = (crew _target) select { !isPlayer _x; };

// Delete dead units
{ deleteVehicle _x; } forEach (_crew select { !alive _x; });

// Move out alive units and prevent them getting back in
{
    moveOut _x;
    _x allowGetIn false;
} forEach _crew;

true;
