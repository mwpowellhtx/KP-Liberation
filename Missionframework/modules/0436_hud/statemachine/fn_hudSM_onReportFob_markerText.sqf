#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_markerText

    File: fn_hudSM_onReportFob_markerText.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 17:39:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Compiles the specific FOB elements of the DISPATCH REPORT.

    Parameters:
        _player - player for whom FOB report is compiled [OBJECT, default: objNull]
        _context - the DISPATCH REPORT context [LOCATION, locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = [
    [
        {MPARAM(_onReportFob_debug)}
        , {MPARAM(_onReportFob_markerText_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

[
    _context getVariable [Q(_fobMarkers), []]
    , _context getVariable [Q(_reportAllResources), false]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobMarkers)
    , Q(_reportAllResources)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_markerText] Entering: [count _fobMarkers]: %1"
        , str [count _fobMarkers]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// Deduced player requesting ONE or ALL, 0) no report, 1) ONE FOB, 2+) ALL FOBS
// Also assuming that the FOB MARKERS are in some kind of ASCENDING DISTANCE order
private _markerText = switch (true) do {
    case (count _fobMarkers == 0): {
        "";
    };
    case (!_reportAllResources && count _fobMarkers == 1): {
        markerText (_fobMarkers#0);
    };
    default {
        "All FOBs";
    };
};

// Now report MARKER TEXT and corresponding COLOR
if (!(_markerText isEqualTo "")) then {
    _compiledReport append [
        [QMVAR(_fobReport_markerText), toUpper _markerText]
        , [QMVAR(_fobReport_markerColor), +KPLIB_preset_fobs_hudColor]
        , [QMVAR(_fobReport_markerPath), KPLIB_preset_fobs_markerPath]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_markerText] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
