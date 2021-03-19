/*
    KPLIB_fnc_productionSM_onStandbyOrPendingTransit

    File: fn_productionSM_onStandbyOrPendingTransit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 17:17:07
    Last Update: 2021-03-17 17:17:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Transition event handler from PRODUCTION back to a PENDING state, responds to
        one of several scenarios. Bottom line, timer is either being disabled or reset.
        Timer is disabled when QUEUE COMPLETE and not configured to be CONTINUAL. Otherwise,
        timer is reset when either QUEUE COMPLETE and CONTINUAL, or when QUEUE is not COMPLETE.
        Production QUEUE is considered COMPLETE when the last item has been processed.

        In summary:
            1. If QUEUE COMPLETE and NOT CONTINUAL then DISABLE TIMER,
            2. If QUEUE COMPLETE and CONTINUAL then RESET TIMER, and,
            3. If QUEUE NOT COMPLETE then RESET TIMER

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { false; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onStandbyOrPendingTransit", [""]]
];

// TODO: TBD: may also want to align specific storage objects along debug...
private _debug = [
    [
        {KPLIB_param_productionSM_onStandbyOrPendingTransit_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onStandbyOrPendingTransit_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onStandbyOrPendingTransit_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    ["KPLIB_production_queue", []]
    , ["KPLIB_production_lastResource", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_queue"
    , "_lastResource"
];

[
    _queue isEqualTo []
    , _lastResource in KPLIB_resources_indexes
    , KPLIB_param_production_rescheduleLastResource
] params [
    "_complete"
    , "_produced"
    , "_reschedule"
];

private _timer = switch (true) do {
    case (!_complete): {
        // TODO: TBD: setup API functions for timers in either direction...
        // TODO: TBD: and then, maybe we route this in terms of that process one immediate change queue change order...
        private _duration = [_namespace] call KPLIB_fnc_productionSM_getProductionTimerDuration;
        [_duration] call KPLIB_fnc_timers_create;
    };
    case (_complete && _reschedule && (_lastResource in KPLIB_resources_indexes)): {
        _queue = [_lastResource];
        // TODO: TBD: setup API functions for timers in either direction...
        // TODO: TBD: and then, maybe we route this in terms of that process one immediate change queue change order...
        private _duration = [_namespace] call KPLIB_fnc_productionSM_getProductionTimerDuration;
        [_duration] call KPLIB_fnc_timers_create;
    };
    default { +KPLIB_timers_default; };
};

[_namespace, [
    ["KPLIB_production_queue", _queue]
    , ["KPLIB_production_timer", _timer]
]] call KPLIB_fnc_namespace_setVars;

true;
