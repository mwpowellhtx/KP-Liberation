#include "script_component.hpp"
/*
    KPLIB_fnc_missionsCO_onRequestAbort

    File: fn_missionsCO_onRequestAbort.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 10:01:26
    Last Update: 2021-03-22 10:17:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to client 'onRequest::abort' server events.

    Parameter(s):
        _targetUuid - [STRING, default: ""]
        _targetTemplateUuid - [STRING, default: ""]
        _cid - [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

private _debug = [
    [
        {MPARAM(_onRequestAbort_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_targetUuid), "", [""]]
    , [Q(_targetTemplateUuid), "", [""]]
    , [Q(_cid), -1, [0]]
];

if (_debug) then {
    [format ["[fn_missionsCO_onRequestAbort] Entering: [_targetUuid, _targetTemplateUuid, _cid]: %1"
        , str [_targetUuid, _targetTemplateUuid, _cid]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

private _runningMission = [_targetUuid, _targetTemplateUuid] call KPLIB_fnc_missions_getMissionByUuid;
private _started = [_runningMission, KPLIB_mission_status_started] call KPLIB_fnc_mission_checkStatus;

// May only ABORT a MISSION that is at least RUNNING
[
    _runningMission
    , KPLIB_mission_status_aborting
    , { [(_this#0), KPLIB_mission_status_running
] call KPLIB_fnc_mission_checkStatus}] call KPLIB_fnc_mission_setStatus;

private _verified = [_runningMission, KPLIB_mission_status_aborting] call KPLIB_fnc_mission_checkStatus;

if (_cid > 0) then {
    // TODO: TBD: include an appropriate notification in either direction
    if (_verified) then {} else {};
};

if (_debug) then {
    [format ["[fn_missionsCO_onRequestAbort] Fini: [_verified]: %1"
        , str [_verified]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

true;
