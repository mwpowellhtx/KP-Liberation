#include "script_component.hpp"
/*
    KPLIB_fnc_mission_onNoOp

    File: fn_mission_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-23 10:43:42
    Last Update: 2021-03-23 10:43:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A default, no-op placeholder.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        That the setup process has completed [BOOL]

    Remarks:
        Mission authors should return false while SETUP is in process. When SETUP has completed,
        may return true, which signals the state machine that it is clear to continue to the
        MISSION state.
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

true;
