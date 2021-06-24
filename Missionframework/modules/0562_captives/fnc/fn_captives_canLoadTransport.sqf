#include "script_component.hpp"
/*
    KPLIB_fnc_captives_canLoadTransport

    File: fn_captives_canLoadTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 19:10:59
    Last Update: 2021-06-17 19:11:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:



        // Returns whether the VEHICLE CAN LOAD an ESCORTED UNIT. We do not need to
        // know about that escorted unit, per se, but we do need to know whether the
        // vehicle has EMPTY CARGO POSITIONS.

    Parameter(s):
        _vehicle - a VEHICLE to consider [OBJECT, default: objNull]
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        Whether the VEHICLE CAN LOAD [BOOL]

    References:
        https://community.bistudio.com/wiki/fullCrew
 */

params [
    [Q(_vehicle), objNull, [objNull]]
    , [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_canLoadTransport_debug)
    || (_unit getVariable [QMVAR(_canLoadTransport_debug), false])
    || (_vehicle getVariable [QMVAR(_canLoadTransport_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

_unit setVariable [QMVAR(_transport), nil];

if (isNull _vehicle || isNull _unit) exitWith {
    false;
};

private _emptyPositions = [_vehicle, Q(cargo), true, { isNull (_this#0); }] call KPLIB_fnc_core_getVehiclePositions;

private _alive = alive _vehicle;
private _emptyPosCount = count _emptyPositions;
private _unitNull = isNull _unit;
private _dist = _vehicle distance _unit;

private _kinds = MPRESET(_transportTypes) select { _vehicle isKindOf _x; };
_kinds params [
    [Q(_kind), "", [""]]
];

if (_debug) then {
    // TODO: TBD: logging...
};

if (_alive
    && _emptyPosCount > 0
    && (
        _unitNull
            || _dist <= MPARAM(_loadRange)
    )
    && _kind in MPRESET(_transportTypes)) exitWIth {

    _unit setVariable [QMVAR(_transport), _vehicle];
    true;
};

false;
