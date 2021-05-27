#include "script_component.hpp"
/*
    KPLIB_fnc_hud_subscribe

    File: fn_hud_subscribe.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 11:57:37
    Last Update: 2021-05-27 14:25:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Caller SUBSCRIBES to a HUD REPORT in an WUAE+WAE manner.

    Parameters:
        _options - an associative array of HASHMAP OPTIONS [ARRAY, default: []]
            _reportUuid - the REPORT UUID to use throughout [STRING, default: _defaultUuid]
            _rscLayerName - an RSC LAYER NAME to use throughout [STRING, default: _defaultName]
            _reportPeriod - a REPORT PERIOD to use throughout [SCALAR, default: KPLIB_param_hud_defaultPeriod]
            _onStarting - callback happens before WUAE [CODE, default: {}]
            _onStarted - callback happens AFTER WUAE [CODE, default: {}]

    Returns:
        The report UUID that may be used to filter during event handler callbacks [STRING]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_rscLayer
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

private _defaultLayerName = [] call KPLIB_fnc_uuid_create_string;
private _defaultUuid = [] call KPLIB_fnc_uuid_create_string;
private _defaultCallback = { true; };

params [
    [Q(_options), [], [[]]]
];

private _optionMap = createHashMapFromArray _options;

[
    _optionMap getOrDefault [Q(_reportUuid), _defaultUuid]
    , _optionMap getOrDefault [Q(_rscLayerName), _defaultLayerName]
    , _optionMap getOrDefault [Q(_reportPeriod), MPARAM(_defaultPeriod)]
    , _optionMap getOrDefault [Q(_onStarting), _defaultCallback]
    , _optionMap getOrDefault [Q(_onStarted), _defaultCallback]
] params [
    Q(_reportUuid)
    , Q(_rscLayerName)
    , Q(_reportPeriod)
    , Q(_onStarting)
    , Q(_onStarted)
];

private _debug = MPARAM(_subscribe_debug);

if (_debug) then {
    [format ["[fn_hud_subscribe] Entering: [_reportUuid, _rscLayerName, _reportPeriod]: %1"
        , str [_reportUuid, _rscLayerName, _reportPeriod]], "HUD", true] call KPLIB_fnc_common_log;
};

private _report = [_reportUuid] call MFUNC(_getReport);

{ _report setVariable _x; } forEach [
    [QMVAR(_reportPeriod), _reportPeriod]
    , [QMVAR(_rscLayerName), _rscLayerName]
    , [QMVAR(_rscLayerID), [_rscLayerName] call BIS_fnc_rscLayer]
];

private _actualUuid = _report getVariable QMVAR(_reportUuid);

if (_debug) then {
    [format ["[fn_hud_subscribe] Starting: [_reportUuid, _actualUuid]: %1"
        , str [_reportUuid, _actualUuid]], "HUD", true] call KPLIB_fnc_common_log;
};

[_report] call _onStarting;

[
    { KPLIB_campaignRunning; }
    , { _this call MFUNC(_onReport); }
    , [_report]
] call CBA_fnc_waitUntilAndExecute;

[_report] call _onStarted;

if (_debug) then {
    [format ["[fn_hud_subscribe] Fini: [_actualUuid]: %1"
        , str [_actualUuid]], "HUD", true] call KPLIB_fnc_common_log;
};

_reportUuid;
