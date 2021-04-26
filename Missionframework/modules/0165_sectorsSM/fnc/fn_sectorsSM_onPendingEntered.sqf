#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onPendingEntered

    File: fn_sectorsSM_onPendingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-04-26 14:30:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onPendingEntered_debug)
    || (_namespace getVariable [QMVARSM(_onPendingEntered_debug), false]);

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_timer), []]
    , [_namespace] call MFUNC(_getStatusReport)
    , [_namespace, MSTATUS(_garrisoned), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_markerName)
    , Q(_timer)
    , Q(_statusReport)
    , Q(_garrisoned)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onPendingEntered] Entering: [_markerName, markerText _markerName, _timer, _garrisoned, _statusReport]: %1"
        , str [_markerName, markerText _markerName, _timer, _garrisoned, _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

/*
 *  !!! THIS IS SUPER CRTITICAL !!!
 */
// (Re-)set the SECTOR namespace TIMER when we know that it has been GARRISONED
if (_garrisoned) then {
    // Otherwise we do not know vis-a-vis the state machine conditions when to transition
    private _defaultTimer = [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create;
    [_namespace, QMVAR(_timer), _defaultTimer] call KPLIB_fnc_namespace_timerHasElapsed;
};

_timer = _namespace getVariable [QMVAR(_timer), []];
_statusReport = [_namespace] call MFUNC(_getStatusReport);

// We do not have the necessary knowledge to reset any timers at this phase
if (_debug) then {
    [format ["[fn_sectorsSM_onPendingEntered] Fini: [_markerName, markerText _markerName, _timer, _statusReport]: %1"
        , str [_markerName, markerText _markerName, _timer, _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
