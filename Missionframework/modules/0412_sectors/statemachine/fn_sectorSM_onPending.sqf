#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onPending

    File: fn_sectorSM_onPending.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-06-14 16:56:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://dictionary.com/browse/antithetical
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onPending_debug)
    || (_sector getVariable [QMVARSM(_onPending_debug), false]);

[
    _sector getVariable [QMVAR(_markerName), ""]
    , _sector getVariable [QMVAR(_blufor), false]
    , _sector getVariable [QMVAR(_timer), []]
    , [_sector] call MFUNC(_canCapture)
    , [_sector] call MFUNC(_canActivate)
] params [
    Q(_markerName)
    , Q(_blufor)
    , Q(_timer)
    , Q(_canCapture)
    , Q(_canActivate)
];

if (_debug) then {
    [format ["[fn_sectorSM_onPending] Entering: [_markerName, markerText _markerName, _blufor, _timer, _canCapture, _canActivate]: %1"
        , str [_markerName, markerText _markerName, _blufor, _timer, _canCapture, _canActivate]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

private _timer = [];

// Should always clear out the TIMER in the default, leaving room for the IDLE transition timer
private _defaultTimer = switch (true) do {
    case (!_canActivate):   { [MPARAMSM(_deactivationPeriod)] call KPLIB_fnc_timers_create; };
    case (_canCapture):     { [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create;      };
    default                 { nil                                                           };
};

if (isNil {_defaultTimer}) then {
    _sector setVariable [QMVAR(_timer), nil];
} else {
    _timer = _sector getVariable [QMVAR(_timer), _defaultTimer];
    [_sector, QMVAR(_timer), _timer] call KPLIB_fnc_namespace_timerHasElapsed;
};

_timer = _sector getVariable [QMVAR(_timer), []];

if (_debug) then {
    [format ["[fn_sectorSM_onPending] Fini: [_markerName, markerText _markerName, _canCapture, _canActivate, _timer]: %1"
        , str [_markerName, markerText _markerName, _canCapture, _canActivate, _timer]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
