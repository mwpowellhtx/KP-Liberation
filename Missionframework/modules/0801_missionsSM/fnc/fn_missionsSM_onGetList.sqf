#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onGetList

    File: fn_missionsSM_onGetList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 08:35:05
    Last Update: 2021-03-04 08:35:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Publishes MISSIONS to registered managers, as well as returning STILL RUNNING
        MISSIONS for use with the state machine. Also ensures that COMPLETED MISSIONS
        are properly GARBAGE COLLECTED by the MISSIONS module.

    Parameter(s):
        NONE

    Returns:
        The array of CBA MISSIONS namespaces [ARRAY]
 */

// Because we may "see" REGISTRY prior to its being created
if (isNil "KPLIB_missions_registry") exitWith {
    [];
};

// Gets the lists of MISSION TEMPLATES and RUNNING MISSIONS
([] call KPLIB_fnc_missions_onGetLists) params [
    Q(_missionTemplates)
    , Q(_runningMissions)
];

private _completed = KPLIB_mission_status_completed;

// Identify the COMPLETED MISSIONS for subsequent GC
private _completedMissions = _runningMissions select {
    [_x, _completed] call KPLIB_fnc_mission_checkStatus;
};

// Return with the STILL RUNNING MISSION, sans any COMPLETED MISSIONS
private _stillRunningMissions = _runningMissions - _completedMissions;

// GC the COMPLETED MISSIONS
{ [_x] call KPLIB_fnc_mission_onGC; } forEach _completedMissions;

[(_missionTemplates + _stillRunningMissions)] call MFUNC(_onBroadcast);

_stillRunningMissions;
