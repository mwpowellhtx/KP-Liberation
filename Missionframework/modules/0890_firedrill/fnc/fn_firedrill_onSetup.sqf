#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onSetup

    File: fn_firedrill_onSetup.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-22 23:29:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [STATUS]
 */

private _debug = [
    [
        {MPARAM(_onSetup_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mission), locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_firedrill_onSetup] Entering: [isNull _mission]: %1"
        , str [isNull _mission]], "FIREDRILL", true] call KPLIB_fnc_common_log;
};

private _updated = [_mission] call MFUNC(_onUpdate);
private _timer = [MPARAM(_durationSeconds)] call KPLIB_fnc_timers_create;

// Sets up a timer for use throughout the mission
_mission setVariable [QPVAR1(_timer), _timer];

if (_debug) then {
    [format ["[fn_firedrill_onSetup] Fini: [_updated, _timer]: %1"
        , str [_updated, _timer]], "FIREDRILL", true] call KPLIB_fnc_common_log;
};

MSTATUS1(_started);
