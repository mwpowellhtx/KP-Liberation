#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onNoOp

    File: fn_sectorSM_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-06-14 16:57:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Provides an opportunity to report when a no-op state or transition event handler happened.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _context - context describing the no-op report [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_context), [], [[]]]
];

private _debug = MPARAMSM(_onNoOp_debug)
    || (_sector getVariable [QMVARSM(_onNoOp_debug), false])
    ;

[
    _sector getVariable [QMVAR(_markerName), ""]
    , _sector getVariable [QMVAR(_timer), []]
] params [
    Q(_markerName)
    , Q(_timer)
];

if (_debug) then {
    [format ["[fn_sectorSM_onNoOp] Entering: [_markerName, _timer, _context]: %1"
        , str [_markerName, _timer, _context joinString "::"]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: do anything else during no-op?

if (_debug) then {
    ["[fn_sectorSM_onNoOp] Fini", "SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
