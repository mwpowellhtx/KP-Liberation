/*
    KPLIB_fnc_productionsm_onScheduler

    File: fn_productionsm_onScheduler.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 15:42:14
    Last Update: 2021-02-18 15:34:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Evaluates the CBA production '_namespace', mostly stages the timer for
        the transition evaluations to occur following this state.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        When the event handler is finished [BOOL]
 */

private _objSM = KPLIB_productionsm_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_scheduler_debug"
        , { _objSM getVariable ["KPLIB_param_productionsm_scheduler_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_scheduler_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

// Start with the basics, we need to know '_markerName' and '_queue' to begin with
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
// In addition to marker we also need to know whether BLUFOR
private _isBlufor = _markerName in KPLIB_sectors_blufor;
private _queue = _namespace getVariable ["_queue", []];
// Previous occurs only when there was a change queue change order in the previous iterations
private _previousQueue = _namespace getVariable "_previousQueue";
private _timer = _namespace getVariable ["_timer", []];

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Entering: [_markerName, _queue, isNil '_previousQueue']: %1"
        , str [_markerName, _queue, isNil '_previousQueue']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Always refresh the publication timer, as we also depend on routine published snapshots
[] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

private _onExitWith = {
    params [
        ["_namespace", locationNull, [locationNull]]
        , ["_retval", true, [true]]
    ];
    // Clear the previous queue anticipating the next SM cycle
    _namespace setVariable ["_previousQueue", nil];
    _retval;
};

// Outright lost control of the sector...
if (!_isBlufor) exitWith {

    // ...and timer was running
    if (_timer call KPLIB_fnc_timers_isRunning) then {

        // TODO: TBD: may have other side effects... i.e. lost storage, crates, etc
        // Which at least has this precipitous effect
        _namespace setVariable ["_queue", []];
        [_namespace] call KPLIB_fnc_productionsm_onTimerReset;

        if (_debug) then {
            [format ["[fn_productionsm_onScheduler] Sector changed sides: [_markerName, _baseMarkerText, _namespace getVariable '_timer']: %1"
                , str [_markerName, _baseMarkerText, _namespace getVariable '_timer']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
        };
    };

    [_namespace] call _onExitWith;
};

// Nil previous, meaning, scheduler naturally running without manager interference
if (isNil { _previousQueue; }) exitWith {

    // Queue has completed, resets timer
    if (_queue isEqualTo []) then {
        [_namespace] call KPLIB_fnc_productionsm_onTimerReset;
    } else {
        // Otherwise, scheduler is continuing to run, refreshes timer
        [_namespace] call KPLIB_fnc_productionsm_onTimerRefreshOrRestart;
    };

    if (_debug) then {
        [format ["[fn_productionsm_onScheduler] No previous queue, CM: [_markerName, _baseMarkerText, _queue, _namespace getVariable '_timer']: %1"
            , str [_markerName, _baseMarkerText, _queue, _namespace getVariable '_timer']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [_namespace] call _onExitWith;
};

// Does not matter in which direction we subtract, we are simply looking for "different", including remaining
private _zipped = [_queue, _previousQueue, { (_this#0) - (_this#1); }, true] call KPLIB_fnc_linq_zip;

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Zipped: [_markerName, _queue, _previousQueue, _zipped]: %1"
        , str [_markerName, _queue, _previousQueue, _zipped]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_zipped params [
    ["_diffs", [], [[]]]
    , ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

// Nothing in the queue, resets timer
if ((_diffs + _alpha) isEqualTo []) exitWith {

    [_namespace] call KPLIB_fnc_productionsm_onTimerReset;

    if (_debug) then {
        [format ["[fn_productionsm_onScheduler] Nothing enqueued, reset: [_markerName, _baseMarkerText, _namespace getVariable '_timer']: %1"
            , str [_markerName, _baseMarkerText, _namespace getVariable '_timer']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [_namespace] call _onExitWith;
};

// Queue is brand new, restarts timer
if ((_diffs + _bravo) isEqualTo []) exitWith {

    [_namespace] call KPLIB_fnc_productionsm_onTimerRestart;

    if (_debug) then {
        [format ["[fn_productionsm_onScheduler] Brand new queue, restart: [_markerName, _baseMarkerText, _queue, _namespace getVariable '_timer']: %1"
            , str [_markerName, _baseMarkerText, _queue, _namespace getVariable '_timer']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [_namespace] call _onExitWith;
};

// Otherwise we know we have some diffs...
if (count _diffs > 0) exitWith {

    // Heads were different production changed, restarts timer
    if ((_diffs#0) != 0) then {
        [_namespace] call KPLIB_fnc_productionsm_onTimerRestart;
    } else {
        [_namespace] call KPLIB_fnc_productionsm_onTimerRefreshOrRestart;
    };

    if (_debug) then {
        [format ["[fn_productionsm_onScheduler] Eval diffs, restart or refresh: [_markerName, _baseMarkerText, _queue, _diffs, _namespace getVariable '_timer']: %1"
            , str [_markerName, _baseMarkerText, _queue, _diffs, _namespace getVariable '_timer']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [_namespace] call _onExitWith;
};

if (_debug) then {
    ["[fn_productionsm_onScheduler] Fini", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
