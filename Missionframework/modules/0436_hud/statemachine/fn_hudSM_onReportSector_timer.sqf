#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportSector_timer

    File: fn_hudSM_onReportSector_timer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:10:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Compiles the specific SECTOR elements of the DISPATCH REPORT.

    Parameters:
        _player - player for whom SECTOR report is compiled [OBJECT, default: objNull]
        _context - the DISPATCH REPORT context [LOCATION, locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = [
    [
        {MPARAM(_onReportSector_debug)}
        , {MPARAM(_onReportSector_timer_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

// _markerName is to _fobs as SECTOR report is to FOB report
[
    _context getVariable [Q(_markerName), ""]
    , _context getVariable [Q(_compiledReport), []]
    // , _context getVariable [Q(_actualRange), 0]
    // , _context getVariable [Q(_targetRange), 0]
] params [
    Q(_markerName)
    , Q(_compiledReport)
    // , Q(_actualRange)
    // , Q(_targetRange)
];

if (_debug) then {
    [format ["[fn_hudSM_onReportSector_engaged] Entering: [_markerName]: %1"
        , str [_markerName]], "HUDSM", true] call KPLIB_fnc_common_log;
};

if (!(_markerName isEqualTo "")) then {
    _compiledReport append [
        [QMVAR(_sectorReport_timer), +KPLIB_timers_default]
        // TODO: TBD: color depending on certain thresholds, perhaps a default white, yellow, orange, red
        , [QMVAR(_sectorReport_timerColor), [1, 1, 1, 1]]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportSector_engaged] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
