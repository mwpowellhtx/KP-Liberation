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

private _runningMission = [_targetUuid, _targetTemplateUuid, KPLIB_missions_running] call KPLIB_fnc_missions_getMissionByUuid;

[
    KPLIB_mission_status_standby
    , KPLIB_mission_status_running
    , KPLIB_mission_status_aborting
] params [
    Q(_standby)
    , Q(_running)
    , Q(_aborting)
];

// Cannot ABORT a MISSION that is not already RUNNING
[_runningMission, _aborting, { ((_this#0) getVariable [QMVAR(_status), _standby]) == _running; }] call KPLIB_fnc_missions_setStatus;

[
    [_runningMission, _aborting] call KPLIB_fnc_missions_checkStatus
] params [
    Q(_verified)
];

// TODO: TBD: report back to the calling '_cid' as appropriate
// TODO: TBD: i.e. when _cid is a player, and depending on _verified

if (_debug) then {
    ["[fn_missionsCO_onRequestAbort] Fini", "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

true;
