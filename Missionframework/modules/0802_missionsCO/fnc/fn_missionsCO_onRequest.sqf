#include "script_component.hpp"
/*
    KPLIB_fnc_missionsCO_onRequest

    File: fn_missionsCO_onRequest.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 10:01:26
    Last Update: 2021-03-22 10:01:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to client 'onRequest' server events for either RUN or ABORT activity.
        If RUN, then TARGET UUID is expected to be a MISSION TEMPLATE. If ABORT, then
        TARGET UUID is expected to be a RUNNING MISSION.

    Parameter(s):
        _requestName - the request name, either 'run' or 'abort', case insensitive [STRING, default: KPLIB_missionsCO_requestRun]
        _targetUuid - a target UUID being either run or aborted [STRING, default: ""]
        _cid - a client identifier making the request [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

private _debug = [
    [
        {MPARAM(_onRequest_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_requestName), MVAR(_requestRun), [""]]
    , [Q(_targetUuid), "", [""]]
    , [Q(_cid), -1, [0]]
];

if (_debug) then {
    [format ["[fn_missionsCO_onRequest] Entering: [_requestName, _targetUuid, _cid]: %1"
        , str [_requestName, _targetUuid, _cid]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

private _onInvalidRequest = {
    if (_debug) then {
        [format ["[fn_missionsCO_onRequest] Invalid request: [_requestName, _targetUuid, _cid]: %1"
            , str [_requestName, _targetUuid, _cid]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
    };
    false;
};

// And route the REQUEST to the appropriate callback
private _onRequest = MVAR(_requestCallbacks) getOrDefault [toLower _requestName, _onInvalidRequest];
private _requested = [_targetUuid, _cid] call _onRequest;

if (_debug) then {
    [format ["[fn_missionsCO_onRequest] Fini: [_requested]: %1"
        , str [_requested]], "MISSIONSCO", true] call KPLIB_fnc_common_log;
};

_requested;
