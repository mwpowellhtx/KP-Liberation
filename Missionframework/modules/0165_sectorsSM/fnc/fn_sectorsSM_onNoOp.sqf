#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onNoOp

    File: fn_sectorsSM_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-22 15:04:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Provides an opportunity to report when a no-op state or transition event handler happened.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _context - context describing the no-op report [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = MPARAMSM(_onNoOp_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_context), [], [[]]]
];

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_timer), []]
    , [_namespace] call MFUNC(_getStatusReport)
] params [
    Q(_markerName)
    , Q(_timer)
    , Q(_statusReport)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onNoOp] Entering: [_markerName, _timer, _context, _statusReport]: %1"
        , str [_markerName, _timer, _context joinString "::", _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: do anything else during no-op?

if (_debug) then {
    ["[fn_sectorsSM_onNoOp] Fini", "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
