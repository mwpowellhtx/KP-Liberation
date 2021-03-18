/*
    KPLIB_fnc_productionSM_onScheduleTimer

    File: fn_productionSM_onScheduleTimer.sqf
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

private _debug = [
    [
        {KPLIB_param_productionSM_onScheduleTimer_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onScheduleTimer_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionSM_onScheduleTimer_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    ["KPLIB_production_queue", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_queue"
];

// This is the rub, "TIMER RUNNING" is a function of "ANYTHING QUEUED"
[
    _queue isEqualTo []
] params [
    "_complete"
];

// If there is a QUEUE, then RESCHEDULE, that is all we care about
private _timer = if (_complete) then {
    +KPLIB_timers_default
} else {
    [
        [_namespace] call KPLIB_fnc_productionSM_getProductionTimerDuration
    ] call KPLIB_fnc_timers_create;
};

[_namespace, [
    ["KPLIB_production_timer", _timer]
]] call KPLIB_fnc_namespace_setVars;

true;
