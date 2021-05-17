#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onCapturedEntered

    File: fn_sectorsSM_onCapturedEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 20:48:40
    Last Update: 2021-04-25 20:07:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Once all CAPTURING and CAPTURED events, states, transitions, etc, have
        evaluated, then we are clear to drop the flags. That should prohibit us
        cycling through further false conditions.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onCapturedEntered_debug)
    || (_namespace getVariable [QMVARSM(_onCapturedEntered_debug), false]);

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturedEntered] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

[MVAR(_captured), [_namespace]] call CBA_fnc_serverEvent;

// Captured is CAPTURED, once complete, clear the flags, they should not be required again
[_namespace, MSTATUS(_capturingCaptured), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

// Reset the timer anticipating the next PENDING iteration which should restart the counter again
_namespace setVariable [QMVAR(_timer), nil];

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturedEntered] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
