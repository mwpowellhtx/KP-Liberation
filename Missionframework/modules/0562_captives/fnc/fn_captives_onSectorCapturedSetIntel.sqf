#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedSetIntel

    File: fn_captives_onSectorCapturedSetIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 19:36:19
    Last Update: 2021-06-16 19:36:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedSetIntel_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedSetIntel_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (_debug) then {
    // TODO: TBD: logging...
};

if (!(_sideOnActivation == KPLIB_preset_sideE || _captured)) exitWith {
    false;
};

private _ratioBundle = _sector getVariable [Q(KPLIB_garrison_ratioBundle), []];

// TODO: TBD: we are doing this frequently enough throughout the capture events...
// TODO: TBD: might make better sense to install it one time in the sector for use throughout...
_ratioBundle params [
    Q(_0) // _civRepRatio
    , [Q(_opforStrengthRatio), 0, [0]]
    , [Q(_opforAwarenessRatio), 0, [0]]
    , [Q(_bluforStrengthRatio), 0, [0]]
];

[
    [MPARAM(_intelDieSides), _opforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
    , [MPARAM(_intelDieTimes), 1 - _opforAwarenessRatio] call KPLIB_fnc_core_getIndexedNumber
    , [MPARAM(_intelDieOffsets), _bluforStrengthRatio] call KPLIB_fnc_core_getIndexedNumber
] params [
    Q(_sides)
    , Q(_times)
    , Q(_offset)
];

// Surrendered UNITS change SIDE, but should still be in the ACTIVATION UNITS array
private _actUnits = _sector getVariable [Q(KPLIB_sectors_actUnits), []];

private _unitsToSet = _actUnits select {
    (_x getVariable [Q(KPLIB_surrender), false])
        && (_x getVariable [QMVAR(_intel), -1] < 0);
};

{
    private _intel = [_side, _times, true, _offset] call KPLIB_fnc_linq_roll;
    _x setVariable [QMVAR(_intel), _intel];
} forEach _unitsToSet;

if (_debug) then {
    // TODO: TBD: logging...
};

true;
