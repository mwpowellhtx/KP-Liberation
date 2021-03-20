#include "script_component.hpp"
/*
    KPLIB_fnc_exampleMission_onMissionTearDown

    File: fn_exampleMission_onMissionTearDown.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 17:03:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Mission tear down callback.

    Parameter(s):
        _namespace - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

true;
