#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onMission

    File: fn_firedrill_onMission.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 17:03:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Routine CBA MISSION 'onState' state machine event handler, invoked during
        the normal course of the mission running and as long as it has not been flagged
        ABORTING, nor either of its terminal outcomes, SUCCESS or FAILURE, indicated.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

// And follow on with another update
[_mission] call MFUNC(_onUpdate);

[
    [QPVAR1(_timer), +KPLIB_timers_default]
    , [Q(_playersWithin), []]
] apply {
    _mission getVariable _x;
} params [
    Q(_timer)
    , Q(_playersWithin)
];

[
    _timer call KPLIB_fnc_timers_hasElapsed
    , count _playersWithin
] params [
    Q(_elapsed)
    , Q(_playerWithinCount)
];

switch (true) do {
    case (_playerWithinCount > 0 && _elapsed): {
        KPLIB_mission_status_failure;
    };
    case (_playerWithinCount == 0 && !_elapsed): {
        KPLIB_mission_status_success;
    };
    default {
        KPLIB_mission_status_standby;
    };
};
