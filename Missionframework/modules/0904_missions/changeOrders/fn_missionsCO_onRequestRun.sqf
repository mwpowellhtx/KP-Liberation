#include "script_component.hpp"
/*
    KPLIB_fnc_missionsCO_onRequestRun

    File: fn_missionsCO_onRequestRun.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 10:01:26
    Last Update: 2021-03-22 10:17:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to client 'onRequest::run' server events given targetUUID and targetTemplateUUID.

    Parameter(s):
        _targetUuid - a target MISSION UUID being requested [STRING, default: ""]
        _cid - a client identifier originating the request [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

private _debug = [
    [
        {MPARAM(_onRequestRun_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_targetUuid), "", [""]]
    , [Q(_cid), -1, [0]]
];

if (_debug) then {
    [format ["[fn_missionsCO_onRequestRun] Entering: [_targetUuid, _cid]: %1"
        , str [_targetUuid, _cid]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

private [Q(_title)];
private _runningMission = ["", _targetUuid] call KPLIB_fnc_missions_getMissionByUuid;

if (!isNull _runningMission) exitWith {
    _title = _runningMission getVariable ["KPLIB_mission_title", ""];
    [format [localize "STR_KPLIB_MISSIONSCO_RUN_MISSION_NAK", _title]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    false;
};

private _sourceMission = [_targetUuid] call KPLIB_fnc_missions_getMissionByUuid;

if (!isNull _sourceMission) then {
    _runningMission = [_sourceMission] call KPLIB_fnc_missions_cloneMission;
    _runningMission setVariable [QMVAR(_cid), _cid];
    [_runningMission] call KPLIB_fnc_missions_registerOne;

    _title = _runningMission getVariable ["KPLIB_mission_title", ""];
    [format [localize "STR_KPLIB_MISSIONSCO_RUN_MISSION_ACK", _title]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
};

// That is all, hands free, let the state machine pick up registered bits and run with them

if (_debug) then {
    ["[fn_missionsCO_onRequestRun] Fini", "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

true;
