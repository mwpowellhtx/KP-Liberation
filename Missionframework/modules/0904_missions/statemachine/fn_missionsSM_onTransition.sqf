#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onTransition

    File: fn_missionsSM_onTransition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 12:22:56
    Last Update: 2021-03-23 22:37:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _mission - a CBA MISSION namespace during a transition [LOCATION, default: locationNull]
        _callbackName - the CALLBACK name [STRING, default: 'KPLIB_fnc_mission_onSetupLeaving']
        _defaultCallback - a default callback [CODE, default: KPLIB_fnc_mission_onNoOp]

    Returns:
        The callback has finished [BOOL]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {MPARAM(_onTransition_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mission), locationNull, [locationNull]]
    , [Q(_callbackName), "KPLIB_fnc_mission_onMissionEntered", [""]]
    , [Q(_defaultCallback), KPLIB_fnc_mission_onNoOp, [{}]]
];

if (_debug) then {
    [format ["[fn_missionsSM_onTransition] Entering: [isNull _mission, _callbackName]: %1"
        , str [isNull _mission, _callbackName]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: for now we are only wired for 'setup::onStateLeaving' ...
if (!(_callbackName in [
    "KPLIB_fnc_mission_onSetupEntered"
    , "KPLIB_fnc_mission_onSetupLeaving"
    , "KPLIB_fnc_mission_onMissionEntered"
    , "KPLIB_fnc_mission_onMissionLeaving"
    , "KPLIB_fnc_mission_onTearDownEntered"
    , "KPLIB_fnc_mission_onTearDownLeaving"
    , "KPLIB_fnc_mission_onCompleteEntered"
])) exitWith {
    false;
};

private _gc = false;
private _callback = _mission getVariable [_callbackName, _defaultCallback];
private _result = [_mission] call _callback;

// Mark MISSION ready for GC once it has reach the COMPLETED state
if ([_mission, KPLIB_mission_status_completed] call KPLIB_fnc_mission_checkStatus) then {
    _gc = true;
    [_mission, KPLIB_mission_status_gc] call KPLIB_fnc_mission_setStatus;
};

if (_debug) then {
    [format ["[fn_missionsSM_onTransition] Fini: [_result, _gc]: %1"
        , str [_result, _gc]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
