#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onCapturedEntered

    File: fn_sectorSM_onCapturedEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 20:48:40
    Last Update: 2021-06-14 16:57:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Once all CAPTURING and CAPTURED events, states, transitions, etc, have
        evaluated, then we are clear to drop the flags. That should prohibit us
        cycling through further false conditions.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onCapturedEntered_debug)
    || (_sector getVariable [QMVARSM(_onCapturedEntered_debug), false]);

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorSM_onCapturedEntered] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

[QMVAR(_captured), [_sector]] call CBA_fnc_serverEvent;

// TODO: TBD: may add another event handler or include this line in one of the existing ones
_sector setVariable [QMVAR(_timer), [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create];

if (_debug) then {
    [format ["[fn_sectorSM_onCapturedEntered] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
