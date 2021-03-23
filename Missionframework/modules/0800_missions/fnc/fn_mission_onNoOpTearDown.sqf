#include "script_component.hpp"
/*
    KPLIB_fnc_mission_onNoOpTearDown

    File: fn_mission_onNoOpTearDown.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-23 10:43:42
    Last Update: 2021-03-23 10:43:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A default no-op 'onTearDown' placeholder. Does nothing, returns
        KPLIB_mission_status_completed always.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [STATUS]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

MSTATUS1(_completed);
