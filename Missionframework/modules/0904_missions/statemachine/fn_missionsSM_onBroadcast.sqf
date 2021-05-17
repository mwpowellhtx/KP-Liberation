#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onBroadcast

    File: fn_missionsSM_onBroadcast.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 13:30:33
    Last Update: 2021-03-22 14:31:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Publishes the missions to all listening missions managers.

    Parameters:
        _cids - the client identifiers to address with the missions publication [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

if (isNil QMVAR(_objSM)) exitWith {
    false;
};

private _debug = [
    [
        {MPARAM(_onBroadcast_debug)}
    ]
] call MFUNC(_debug);

private _objSM = MVAR(_objSM);

params [
    [Q(_missions), [], [[]]]
    , [Q(_cids), (_objSM getVariable [QMVAR(_cids), []]), [[]]]
];

if (_debug) then {
    [format ["[fn_missionsSM_onBroadcast] Entering: [_cids, changed(_objSM)]: %1"
        , str [_cids, _objSM getVariable [KPLIB_namespace_changed, false]]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

if (_cids isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_missionsSM_onBroadcast] No managers", "MISSIONSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _onBroadcastToListeners = {
    params [
        [Q(_missions), [], [[]]]
        , [Q(_cids), [], [[]]]
        , [Q(_forced), false, [false]]
    ];

    [
        ({ (_x getVariable [KPLIB_namespace_changed, false]); } count _missions) > 0
    ] params [
        Q(_changed)
    ];

    // We want MISSION TEMPLATES before RUNNING MISSIONS
    private _sorted = [_missions, [], {
        // TODO: TBD: ...and then we may want other criteria as well...
        private _template = [_x, KPLIB_mission_status_template] call KPLIB_fnc_mission_checkStatus;
        if (_template) then {0} else {1};
    }] call BIS_fnc_sortBy;

    // Publish only when a change has been detected during set variables
    if (_changed || _forced) then {
        if (_debug) then {
            [format ["[fn_missionsSM_onBroadcast::_onBroadcastToListeners] Publishing: [count _sorted, _cids]: %1"
                , str [count _sorted, _cids]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
        };

        private _tuplesToPublish = _sorted apply {
            [_x] call KPLIB_fnc_mission_namespaceToArray;
        };

        {
            [_x, _tuplesToPublish] call KPLIB_fnc_missionsSM_onPublish;
        } forEach _cids;
    };
};

[_objSM, KPLIB_missions_registry, _cids] call {
    params [
        [Q(_objSM), locationNull, [locationNull]]
        , [Q(_registry), emptyHashMap, [emptyHashMap]]
        , [Q(_cids), [], [[]]]
    ];

    private _defaultTimer = [MPARAM(_broadcastPeriodSeconds)] call KPLIB_fnc_timers_create;

    [
        [KPLIB_namespace_changed, false]
        , [QMVAR(_publicationTimer), +_defaultTimer]
    ] apply {
        _objSM getVariable _x;
    } params [
        Q(_changed)
        , Q(_timer)
    ];

    private _refreshedTimer = _timer call KPLIB_fnc_timers_refresh;
    private _elapsed = _refreshedTimer call KPLIB_fnc_timers_hasElapsed;

    if (_changed || _elapsed) then {
        private _missions = (keys _registry) apply { _registry get _x; };
        [_missions, _cids, _changed || _elapsed] call _onBroadcastToListeners;
        _refreshedTimer = +_defaultTimer;
    };

    if (_debug) then {
        [format ["[fn_missionsSM_onBroadcast::call] Fini: [_changed, _elapsed, _defaultTimer, _refreshedTimer]: %1"
            , str [_changed, _elapsed, _defaultTimer, _refreshedTimer]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
    };

    { _objSM setVariable _x; } forEach [
        [QMVAR(_publicationTimer), _refreshedTimer]
        , [KPLIB_namespace_changed, false]
    ];
};

if (_debug) then {
    ["[fn_missionsSM_onBroadcast] Fini", "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
