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

// Scheduler also needs to consider the publication timer during its transitions
[] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

params [
    ["_namespace", locationNull, [locationNull]]
];

// Start with the basics, we need to know '_markerName' and '_queue' to begin with
[
    _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault]
    , _namespace getVariable ["_queue", []]
] params [
    "_markerName"
    , "_queue"
];

// Refresh the publication timer with every visit
private _publicationTimer = [_namespace] call {
    params ["_namespace"];
    private _timer = _namespace getVariable ["_publicationTimer", (+KPLIB_timers_default)];
    _timer = _timer call KPLIB_fnc_timers_refresh;
    _namespace setVariable ["_publicationTimer", _timer];
    _timer;
};

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Entering: [_markerName, _queue]: %1"
        , str [_markerName, _queue]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: these might make some sense to refactor as first class config functions...
private _onTimerReset = {
    _this setVariable ["_timer", (+KPLIB_timers_default)];
};

private _onTimerRestart = {
    _this setVariable ["_timer", ([KPLIB_param_production_leadTime] call KPLIB_fnc_timers_create)];
};

private _onTimerRefresh = {
    private _timer = _this getVariable ["_timer", (+KPLIB_timers_default)];
    _this setVariable ["_timer", (_timer call KPLIB_fnc_timers_refresh)];
};

private _onExit = {
    // Clear the previous queue anticipating the next SM cycle
    _this setVariable ["_previousQueue", nil];
};

// TODO: TBD: we should also take a step back and during notification, report changes to listeners as well...

/* Deciding what to do with a running production SM starts with the '_queue' itself,
 * and extends to the most recently known '_previousQueue' state. */

/* From which we derive several other levels of insight:
 *  - Noteworthy, previous queue the same, no change, whether that happened from
 *      event, or a naturally running timer, matters not, in which case, continue
 *      mission, CM, keep running.
 */
[
    _markerName in KPLIB_sectors_blufor
    , _queue isEqualTo []
    , _namespace getVariable ["_previousQueue", (+_queue)]
    , _namespace getVariable ["_timer", (+KPLIB_timers_default)]
] params [
    "_isBlufor"
    , "_isQueueEmpty"
    , "_previousQueue"
    , "_timer"
];

if (_debug) then {
    [format ["[fn_productionsm_onScheduler] Additional bits: [_isBlufor, _isQueueEmpty, _previousQueue, _timer]: %1"
        , str [_isBlufor, _isQueueEmpty, _previousQueue, _timer]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: re: '_isBlufor', and possibly other side effects... i.e. ...
// TODO: TBD: we might involve a "losing sector" state later on...
// TODO: TBD: whose interesting side effects, among other things, would be to delay production, perhaps...
// TODO: TBD: or to erradicate stored crates...
// TODO: TBD: even destroy the storage itself...
// TODO: TBD: will delay all this for later consideration...

// // TODO: TBD: these belong rather as an event transition, on transition event handler, perhaps...
//_namespace setVariable ["_timer", +KPLIB_timers_default];
//_namespace setVariable ["_queue", []];
//_namespace setVariable ["_previousQueue", nil];
//_namespace setVariable ["_changeOrders", nil];

/* Looking for one of several timer outcomes here, which that, coupled with queue, criteria inform transitions:
 *  - reset: queue empty, production fini
 *  - restart: production changed, new production
 *  - refresh: production unchanged, keep counting
 */
if (_isQueueEmpty || !_isBlufor) exitWith {

    if (_debug) then {
        ["[fn_productionsm_onScheduler] Timer reset or sector lost", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    _namespace call _onTimerReset;
    _namespace call _onExit;

    true;
};

// Restart the timer when we know the previous was empty, not running
if (_previousQueue isEqualTo []) exitWith {

    if (_debug) then {
        ["[fn_productionsm_onScheduler] Restarting", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    _namespace call _onTimerRestart;
    _namespace call _onExit;

    true;
};

// Queues themselves can be different, but next on deck is the same
if ((_queue#0) isEqualTo (_previousQueue#0)) exitWith {

    if (_debug) then {
        ["[fn_productionsm_onScheduler] No change or timer restart", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    // This part is critical, i.e. whether to refresh or restart
    if (timer call KPLIB_fnc_timers_isRunning) then {
        _namespace call _onTimerRefresh;
    } else {
        _namespace call _onTimerRestart;
    };

    _namespace call _onExit;

    true;
};

_namespace call _onTimerRestart;
_namespace call _onExit;

if (_debug) then {
    ["[fn_productionsm_onScheduler] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
