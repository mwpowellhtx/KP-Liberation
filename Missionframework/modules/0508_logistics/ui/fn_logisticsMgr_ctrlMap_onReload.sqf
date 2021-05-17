/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReload

    File: fn_logisticsMgr_ctrlMap_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 22:02:06
    Last Update: 2021-03-01 22:02:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _ctrlMap - a map control [CONTROL, default: controlNull]
        _pos - a 3D position at which to center the map [POSITION]
        _target - an optional target on which to center [OBJECT, default: objNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_ctrlMap_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_target", objNull, [objNull]]
    , ["_ctrlMap", (uiNamespace getVariable ["KPLIB_logisticsMgr_ctrlMap", controlNull]), [controlNull]]
];

if (!isNull _target) then {
    _pos = getPos _target;
};

if (_debug) then {
    [format ["[fn_logisticsMgr_ctrlMap_onReload] Entering: [_pos, isNull _target, isNull _ctrlMap]: %1"
        , str [_pos, isNull _target, isNull _ctrlMap]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _cboEndpoint = uiNamespace getVariable ["KPLIB_logisticsMgr_cboEndpoint", controlNull];
private _selectedLine = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_selectedLine params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_endpoints", [], [[]]]
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

private _playerPos = getPos player;

private _animPos = switch (true) do {
    case ([_status, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_checkStatus): {
        if (_debug) then {
            [format ["[fn_logisticsMgr_ctrlMap_onReload] Loading: [isNull _ctrlMap, _alpha]: %1"
                , str [isNull _ctrlMap, _alpha]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };
        [_ctrlMap, _alpha] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadLoading;
    };
    case ([_status, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus): {
        if (_debug) then {
            [format ["[fn_logisticsMgr_ctrlMap_onReload] Unloading: [isNull _ctrlMap, _bravo]: %1"
                , str [isNull _ctrlMap, _bravo]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };
        [_ctrlMap, _bravo] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadUnloading;
    };
    case ([_status, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logistics_checkStatus): {
        if (_debug) then {
            [format ["[fn_logisticsMgr_ctrlMap_onReload] En route: [isNull _ctrlMap, _timer, _alpha, _bravo]: %1"
                , str [isNull _ctrlMap, _timer, _alpha, _bravo]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };
        [_ctrlMap, _timer, _alpha, _bravo] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadEnRoute;
    };
    case (!isNull _target): {
        if (_debug) then {
            [format ["[fn_logisticsMgr_ctrlMap_onReload] Target: [typeOf _target, _pos]: %1"
                , str [typeOf _target, _pos]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };
        [_ctrlMap] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadStandby;
        _pos;
    };
    default {
        if (_debug) then {
            [format ["[fn_logisticsMgr_ctrlMap_onReload] Default: [_pos]: %1"
                , str [_pos]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };
        _pos;
    };
};

[_ctrlMap, _animPos] call {
    params [
        ["_ctrlMap", controlNull, [controlNull]]
        , ["_pos", +KPLIB_zeroPos, [[]], 3]
    ];

    private _ctrlMap = uiNamespace getVariable ["KPLIB_logisticsMgr_ctrlMap", controlNull];

    // TODO: TBD: is there a way to get the map current zoom? does not sound like it...
    _ctrlMap ctrlMapAnimAdd [0.35, 0.1, _pos];

    // TODO: TBD: when we "reload" the map in this manner, we will also want to consider factory storage markers as well...
    // TODO: TBD: probably think of a common production/logistics refactoring...
    _ctrlMap setVariable ["KPLIB_logisticsMgr_pos", _pos];

    ctrlMapAnimCommit _ctrlMap;
};

true;
