#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_intel

    File: fn_hudSM_onReportFob_intel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:09:19
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
        , {MPARAM(_onReportFob_intel_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

[
    _context getVariable [Q(_fobs), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_intel] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    [
        KPLIB_resources_intel
        , KPLIB_preset_common_intelPath
        , +KPLIB_preset_common_intelColor
    ] params [
        Q(_intel)
        , Q(_intelPath)
        , Q(_intelColor)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_intel), [_intel] call MFUNC(_renderScalar)]
        , [QMVAR(_fobReport_intelPath), _intelPath]
        , [QMVAR(_fobReport_intelColor), +_intelColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_intel] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
