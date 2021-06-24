#include "script_component.hpp"
/*
    KPLIB_fnc_captives_getLoadedCaptives

    File: fn_captives_getLoadedCaptives.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-18 11:06:18
    Last Update: 2021-06-18 11:06:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        When CAPTIVE UUID is provided, returns that selected UNIT from the VEHICLE CARGO POSITIONS
        from among units with 'KPLIB_captured'. When unspecified, returns all of the known
        units of the same. Note that CAPTIVE UINT does not correspond to the actual CARGO position,
        but rather to a UNIT from the cargo positions.

    Parameter(s):
        _vehicle - a VEHICLE to consider [OBJECT, default: objNull]
        _unitUuid - a UNIT UUID to consider [STRING, default: ""]

    Returns:
        A single UNIT corresponding to the CAPTIVE UUID, or an ARRAY of UNITS [OBJECT|ARRAY]
 */

params [
    [Q(_vehicle), objNull, [objNull]]
    , [Q(_unitUuid), "", [""]]
];

private _debug = MPARAM(_getLoadedCaptives_debug)
    || (_vehicle getVariable [QMVAR(_getLoadedCaptives_debug), false])
    ;

private _whereUuidMatches = {
    params [Q(_unit)];
    private _uuid = _unit getVariable [QMVAR(_uuid), ""];
    private _captured = _unit getVariable [Q(KPLIB_captured), false];
    _captured && (_unitUuid == "" || _uuid == _unitUuid);
};

private _positions = [_vehicle, Q(cargo), false, _whereUuidMatches] call KPLIB_fnc_core_getVehiclePositions;

// Transforming through the VEHICLE POSITION tuples
private _units = _positions apply { _x#0; };

// For when we explicitly requested a UNIT by its UUID
if (count _units == 1 && _unitUuid != "") exitWith {
    _units#0;
};

// Otherwise return with the ARRAY of known matches
_units;
