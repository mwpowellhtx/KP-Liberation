#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedCaptiveTimers

    File: fn_captives_onSectorCapturedCaptiveTimers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 09:30:47
    Last Update: 2021-06-17 09:30:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to 'KPLIB_sectors_captured' event, and applies the 'KPLIB_captives_timers'
        d

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedCaptiveTimers_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedCaptiveTimers_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (_debug) then {
    // TODO: TBD: logging...
};

private _capUnits = _sector getVariable [Q(KPLIB_sectors_capUnits), []];

// Because SURRENDERING UNITS will be CIVILIAN start TIMING their GC at every phase
private _unitsToWatch = _capUnits select { _x getVariable [Q(KPLIB_surrender), false]; };

{
    private _timer = [MPARAM(_captiveTimeout)] call KPLIB_fnc_timers_create;
    _x setVariable [QMVAR(_timer), _timer];
} forEach _unitsToWatch;

if (_debug) then {
    // TODO: TBD: logging...
};

true;
