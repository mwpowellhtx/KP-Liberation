#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onState

    File: fn_missionsSM_onState.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 23:41:15
    Last Update: 2021-03-22 23:41:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        This is a very general use proxy for the MISSION callback at a given state,
        SETUP, MISSION, TEAR DOWN, etc. We are given the CALLBACK NAME, an acceptable
        target BITFLAGS MASK, and the default CALLBACK to use if one was not provided
        by the mission author. STATE callbacks are expected to continue as long as the
        target BITFLAGS MASK was not achieved.

        We also move the TIMER along, if one is attached to the MISSION for any reason,
        prior to invoking the STATE CALLBACK. Not all missions will require a TIMER, so
        this is left entirely to the MISSION author to determine what is best, what
        TIMER DURATION should be involved, etc. Heck, we think that some missions may
        even expose settings via their own set of CBA settings, along these and other
        lines, which would be simply fantastic.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]
        _callbackName - a CALLBACK name attached to the MISSION [STRING, default: 'KPLIB_fnc_missions_onSetup']
        _targetStatusMask - a target STATUS MASK [SCALAR, default: KPLIB_mission_status_started]
        _defaultCallback - a default STATE callback [CODE, default: KPLIP_fnc_mission_onNoOp]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
 */

private _debug = [
    [
        {MPARAM(_onState_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mission), locationNull, [locationNull]]
    , [Q(_callbackName), "KPLIB_fnc_mission_onSetup", [""]]
    , [Q(_targetStatusMask), KPLIB_mission_status_started, [0]]
    , [Q(_defaultCallback), KPLIP_fnc_mission_onNoOpSetup, [{}]]
];

if (_debug) then {
    private _statusMaskReport = [_targetStatusMask] call KPLIB_fnc_mission_getStatusReport;
    [format ["[fn_missionsSM_onState] Entering: [_callbackName, isNull _mission, [_statusMaskReport]]: %1"
        , str [_callbackName, isNull _mission, [_statusMaskReport]]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

// We do not care what TARGET STATUS or DEFAULT CALLBACK are, per se, but we do require the callback
if (!(_callbackName in [
    "KPLIB_fnc_mission_onSetup"
    , "KPLIB_fnc_mission_onMission"
    , "KPLIB_fnc_mission_onTearDown"
])) exitWith {
    false;
};

// It is also expected that TARGET STATUS have a flag
if (_targetStatusMask == KPLIB_mission_status_standby) exitWith {
    false;
};

// We also move the timer along when required to do so, PRIOR to CALLBACK
[_mission getVariable "KPLIB_mission_timer"] call {
    params [Q(_timer)];
    if (_debug) then {
        [format ["[fn_missionsSM_onState:call] Refreshing timer: [_callbackName, isNil _timer]: %1"
            , str [_callbackName, isNil Q(_timer)]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
    };
    if (!isNil Q(_timer)) then {
        // Assuming we have a valid timer
        private _refreshedTimer = _timer call KPLIB_fnc_timers_refresh;
        if (!(_refreshedTimer isEqualTo _timer)) then {
            [_mission, [
                ["KPLIB_mission_timer", _refreshedTimer]
            ]] call KPLIB_fnc_namespace_setVars;
        };
    };
};

// Remember to broadcast during the state
[] call MFUNC(_onBroadcast);

// Evaluates the CALLBACK, only AFTER the MISSION TIMER is REFRESHED
private _status = [_mission getVariable _callbackName] call {
    params [
        [Q(_callback), _defaultCallback, [{}]]
    ];
    if (_debug) then {
        [format ["[fn_missionsSM_onState:call] Invoking callback: [_callbackName, isNil _callback]: %1"
            , str [_callbackName, isNil Q(_timer)]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
    };
    [_mission] call _callback;
};

if (_debug) then {
    [format ["[fn_missionsSM_onState] Verifying status: [_callbackName, _status]: %1"
        , str [_callbackName, _status]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

// STANDBY is acceptable, was neither FAILURE nor SUCCESS, rather CONTINUE MISSION
if (_status == KPLIB_mission_status_standby) exitWith {
    true;
};

// Set and check TARGET STATUS when the conditions are met
if ([_targetStatusMask, _status] call BIS_fnc_bitflagsCheck) then {
    [_mission, _status] call KPLIB_fnc_mission_setStatus;
};

// // When expecting STANDBY then STATUS should be the same
// if (_targetStatusMask == KPLIB_mission_status_standby) exitWith {
//     [_mission] call KPLIB_fnc_mission_checkStatus;
// };

// Otherwise verify the TARGET STATUS MASK
[
    _mission getVariable ["KPLIB_mission_status", KPLIB_mission_status_stanbdy]
    , [_mission, _targetStatusMask] call KPLIB_fnc_mission_checkStatus
] params [
    Q(_newStatus)
    , Q(_checked)
];

if (_debug) then {
    [format ["[fn_missionsSM_onState] Fini: [_callbackName, _status, _newStatus, _checked]: %1"
        , str [_callbackName, _status, _newStatus, _checked]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

_checked;