#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onCompleteEntered

    File: fn_firedrill_onCompleteEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 17:03:39
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

[
    [_mission, KPLIB_mission_status_success] call KPLIB_fnc_mission_checkStatus
    , [_mission, KPLIB_mission_status_failure] call KPLIB_fnc_mission_checkStatus
    , [_mission, KPLIB_mission_status_aborting] call KPLIB_fnc_mission_checkStatus
] apply {
    _mission getVariable _x;
} params [
    Q(_success)
    , Q(_failure)
    , Q(_aborting)
];

private _msg = localize (switch (true) do {
    case (_aborting && !(_success || _failure)): {
        "STR_KPLIB_MISSION_FIREDRILL_MISSION_COMPLETED_ABORTED_TEXT";
    };
    case (_failure): {
        "STR_KPLIB_MISSION_FIREDRILL_MISSION_COMPLETED_FAILURE_TEXT";
    };
    default {
        "STR_KPLIB_MISSION_FIREDRILL_MISSION_COMPLETED_SUCCESS_TEXT";
    };
});

[_mission, _msg] call KPLIB_fnc_mission_onNotify;

true;
