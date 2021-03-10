/*
    KPLIB_fnc_logisticsSM_onBroadcastLines

    File: fn_logisticsSM_onBroadcastLines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 16:48:59
    Last Update: 2021-03-01 14:03:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Publishes the lines to all listening logistics managers.

    Parameters:
        _cids - the client identifiers to address with the lines publication [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsSM_onBroadcastLines_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

private _objSM = missionNamespace getVariable ["KPLIB_logisticsSM_objSM", locationNull];

params [
    ["_cids", (_objSM getVariable ["KPLIB_logistics_cids", []]), [[]]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onBroadcastLines] Entering: [_cids]: %1"
        , str [_cids]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (_cids isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_logisticsSM_onBroadcastLines] No logistics managers", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _onBroadcastToListeners = {
    params [
        ["_namespaces", [], [[]]]
        , ["_cids", [], [[]]]
    ];

    [
        ({ (_x getVariable [KPLIB_namespace_changed, false]); } count _namespaces) > 0
    ] params [
        "_changed"
    ];

    // Publish only when a change has been detected during set variables
    if (_changed) then {
        if (_debug) then {
            [format ["[fn_logisticsSM_onBroadcastLines::_onBroadcastToListeners] Publishing: [_cids]: %1"
                , str [_cids]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
        };

        private _onPublish = {
            params ["_cid"];
            private _published = [_cid] call KPLIB_fnc_logisticsSM_onPublishLines;
        };

        { [_x] call _onPublish; } forEach _cids;
    };
};

[_objSM, KPLIB_logistics_namespaces, _cids] call {
    params [
        ["_objSM", locationNull, [locationNull]]
        , ["_namespaces", [], [[]]]
        , ["_cids", [], [[]]]
    ];

    private _defaultTimer = [KPLIB_param_logisticsSM_broadcastLinesPeriodSeconds] call KPLIB_fnc_timers_create;
    private _timer = _objSM getVariable [KPLIB_logisticsSM_broadcastLinesTimer, +_defaultTimer];

    private _refreshedTimer = _timer call KPLIB_fnc_timers_refresh;

    if (_refreshedTimer call KPLIB_fnc_timers_hasElapsed) then {
        [_namespaces, _cids] call _onBroadcastToListeners;
        _refreshedTimer = +_defaultTimer;
    };

    _objSM setVariable [KPLIB_logisticsSM_broadcastLinesTimer, +_refreshedTimer];
};

if (_debug) then {
    ["[fn_logisticsSM_onBroadcastLines] Fini", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
