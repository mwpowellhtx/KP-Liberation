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

params [
    [Q(_mission), locationNull, [locationNull]]
];

[_mission] call MFUNC(_onUpdate);

// Sets up a timer for use throughout the mission
_mission setVariable [QPVAR1(_timer), [MPARAM(_durationSeconds)] call KPLIB_fnc_timers_create];

MSTATUS1(_started);
