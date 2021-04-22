#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onPending

    File: fn_sectorsSM_onPending.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-04-22 16:15:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://dictionary.com/browse/antithetical
 */

private _debug = MPARAMSM(_onPending_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

/* We will relay mission status via the STATE MACHINE object itself. This is because
 * each SECTOR namespace lacks the context, perspective, necessary in order to make
 * the appropriate decision.
 */
private _objSM = missionNamespace getVariable [QMVARSM(_objSM), locationNull];

[
    _objSM getVariable [QMVAR(_status), MSTATUS(_standby)]
    , _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_timer), []]
    , _namespace getVariable [QMVAR(_blufor), false]
    , _namespace getVariable [QMVAR(_opfor), false]
    , _namespace getVariable [QMVAR(_status), MSTATUS(_standby)]
    , [_namespace] call MFUNC(_getSectorCapturing)
    , [_namespace] call MFUNC(_getSectorDeactivating)
] params [
    Q(_stateMachineStatus)
    , Q(_markerName)
    , Q(_timer)
    , Q(_blufor)
    , Q(_opfor)
    , Q(_namespaceStatus)
    , Q(_canCapture)
    , Q(_canDeactivate)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onPending] Entering: [_markerName, isNull _objSM, _blufor, _opfor, _namespaceStatus, _timer, _canCapture, _canDeactivate]: %1"
        , str [_markerName, isNull _objSM, _blufor, _opfor, _namespaceStatus, _timer, _canCapture, _canDeactivate]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// After SECTOR captures first time round, may clear the flags
[_namespace, MSTATUS(_capturingCaptured), { !_canCapture; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;
[_namespace, MSTATUS(_capturing), { _canCapture; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

[_namespace, MSTATUS(_deactivatingDeactivated), { !_canDeactivate; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;
[_namespace, MSTATUS(_deactivating), { _canDeactivate; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

switch (true) do {
    // Can neither be CAPTURED nor DEACTIVATED i.e. units in proximity
    case (!(_canCapture || _canDeactivate)): {
        // However nothing to be timed so clear TIMER
        _namespace setVariable [QMVAR(_timer), nil];
    };
    case (_canDeactivate): {
        private _defaultTimer = [MPARAMSM(_deactivationPeriod)] call KPLIB_fnc_timers_create;
        [_namespace, QMVAR(_timer), _defaultTimer] call KPLIB_fnc_namespace_timerHasElapsed;
    };
    case (_canCapture): {
        private _defaultTimer = [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create;
        [_namespace, QMVAR(_timer), _defaultTimer] call KPLIB_fnc_namespace_timerHasElapsed;
    };
    // TODO: TBD: there will probably be other timers/conditions that we want to account for as well...
};

_timer = _namespace getVariable [QMVAR(_timer), []];
private _statusReport = [_namespace] call MFUNC(_getStatusReport);

if (_debug) then {
    [format ["[fn_sectorsSM_onPending] Fini: [_markerName, _canCapture, _canDeactivate, _timer, _statusReport]: %1"
        , str [_markerName, _canCapture, _canDeactivate, _timer, _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
