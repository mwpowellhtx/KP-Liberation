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

private _debug = [
    [
        {MPARAM(_onBroadcast_debug)}
    ]
] call MFUNC(_debug);

private _objSM = missionNamespace getVariable [QMVAR(_objSM), locationNull];

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
        ["_missions", [], [[]]]
        , ["_cids", [], [[]]]
        , ["_forced", false, [false]]
    ];

    [
        ({ (_x getVariable [KPLIB_namespace_changed, false]); } count _missions) > 0
    ] params [
        "_changed"
    ];

    // Publish only when a change has been detected during set variables
    if (_changed || _forced) then {
        if (_debug) then {
            [format ["[fn_missionsSM_onBroadcast::_onBroadcastToListeners] Publishing: [count _missions, _cids]: %1"
                , str [count _missions, _cids]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
        };

        private _onPublish = {
            params [
                [Q(_cid), -1, [0]]
                , [Q(_tuplesToPublish), [], [[]]]
            ];
            private _published = [_cid, _tuplesToPublish] call KPLIB_fnc_logisticsSM_onPublish;
        };

        private _missionTuples = _missions apply { [_x] call KPLIB_fnc_mission_namespaceToArray; };

        { [_x, _missionTuples] call _onPublish; } forEach _cids;
    };
};

[_objSM, KPLIB_missions_registry, _cids] call {
    params [
        [Q(_objSM), locationNull, [locationNull]]
        , [Q(_registry), emptyHashMap, [emptyHashMap]]
        , [Q(_cids), [], [[]]]
    ];

    private _defaultTimer = [MVAR(_broadcastPeriodSeconds)] call KPLIB_fnc_timers_create;

    [
        _objSM getVariable [KPLIB_namespace_changed, false]
        , _objSM getVariable [QMVAR(_broadcastTimer), +_defaultTimer]
    ] params [
        Q(_changed)
        , Q(_timer)
    ];

    private _refreshedTimer = _timer call KPLIB_fnc_timers_refresh;

    if (_changed || (_refreshedTimer call KPLIB_fnc_timers_hasElapsed)) then {
        private _missions = (keys _registry) apply { _registry get _x; };
        [_missions, _cids, _changed] call _onBroadcastToListeners;
        _refreshedTimer = +_defaultTimer;
    };

    { _objSM setVariable _x; } forEach [
        [QMVAR(_broadcastTimer), _refreshedTimer]
        , [KPLIB_namespace_changed, false]
    ]
};

if (_debug) then {
    ["[fn_missionsSM_onBroadcast] Fini", "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
