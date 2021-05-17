#include "script_component.hpp"
/*
    KPLIB_fnc_mission_onNoOpMission

    File: fn_mission_onNoOpMission.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-23 10:43:42
    Last Update: 2021-03-23 10:43:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A default no-op 'onMission' placeholder. Does nothing, returns
        KPLIB_mission_status_standby always. This is a placeholder only. Although
        it is not strictly prohibited, it is strongly recommended that missions have
        finite SETUP, MISSION, and TEARDOWN phases.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [STATUS]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

// For those perpetually running missions...
MSTATUS1(_standby);
