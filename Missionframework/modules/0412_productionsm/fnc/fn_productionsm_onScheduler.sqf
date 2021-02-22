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

private _debug = [
    [
        "KPLIB_param_productionsm_scheduler_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

private _objSM = KPLIB_productionsm_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
];

// Start with the basics, we need to know '_markerName' and '_queue' to begin with
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
// In addition to marker we also need to know whether BLUFOR
private _isBlufor = _markerName in KPLIB_sectors_blufor;
private _queue = _namespace getVariable ["_queue", []];
// Previous occurs only when there was a change queue change order in the previous iterations
private _previousQueue = _namespace getVariable "_previousQueue";

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Entering: [_markerName, _queue, isnil '_previousQueue']: %1"
        , str [_markerName, _queue, isNil '_previousQueue']], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Always refresh the publication timer, as we also depend on routine published snapshots
[] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

// TODO: TBD: these might make some sense to refactor as first class config functions...
private _onTimerReset = {
    _this setVariable ["_timer", (+KPLIB_timers_default)];
};

private _onTimerRestart = {
    _this setVariable ["_timer", ([KPLIB_param_production_leadTime] call KPLIB_fnc_timers_create)];
};

// Handles the warm refresh cases, as well as the cold boot unstarted cases
private _onTimerRefresh = {
    private _timer = _this getVariable ["_timer", (+KPLIB_timers_default)];
    if (_timer call KPLIB_fnc_timers_isRunning) then {
        _this setVariable ["_timer", (_timer call KPLIB_fnc_timers_refresh)];
    } else {
        _this call _onTimerRestart;
    };
};

private _onExitWith = {
    params [
        ["_namespace", locationNull, [locationNull]]
        , ["_retval", true, [true]]
    ];
    // Clear the previous queue anticipating the next SM cycle
    _namespace setVariable ["_previousQueue", nil];
    _retval;
};

// Outright lost control of the sector
if (!_isBlufor) exitWith {
    // TODO: TBD: may have other side effects... i.e. lost storage, crates, etc
    // Which at least has this precipitous effect
    _namespace setVariable ["_queue", []];
    _namespace call _onTimerReset;
    [_namespace] call _onExitWith;
};

// Nil previous, meaning, scheduler naturally running without manager interference
if (isNil { _previousQueue; }) exitWith {

    // Queue has completed, resets timer
    if (_queue isEqualTo []) then {
        _namespace call _onTimerReset;
    } else {
        // Otherwise, scheduler is continuing to run, refreshes timer
        _namespace call _onTimerRefresh;
    };

    [_namespace] call _onExitWith;
};

// Does not matter in which direction we subtract, we are simply looking for "different", including remaining
private _zipped = [_queue, _previousQueue, { (_this#0) - (_this#1); }, true] call KPLIB_fnc_linq_zip;

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Entering: [_markerName, _queue, _previousQueue, _zipped]: %1"
        , str [_markerName, _queue, _previousQueue, _zipped]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_zipped params [
    ["_diffs", [], [[]]]
    , ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

// Nothing in the queue, resets timer
if ((_diffs + _alpha) isEqualTo []) exitWith {
    _namespace call _onTimerReset;
    [_namespace] call _onExitWith;
};

// Queue is brand new, restarts timer
if ((_diffs + _bravo) isEqualTo []) exitWith {
    _namespace call _onTimerRestart;
    [_namespace] call _onExitWith;
};

// Otherwise we know we have some diffs...
if (count _diffs > 0) exitWith {

    // Heads were different production changed, restarts timer
    if ((_diffs#0) != 0) then {
        _namespace call _onTimerRestart;
    } else {
        _namespace call _onTimerRefresh;
    };

    [_namespace] call _onExitWith;
};

if (_debug) then {
    ["[fn_productionsm_onScheduler] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
