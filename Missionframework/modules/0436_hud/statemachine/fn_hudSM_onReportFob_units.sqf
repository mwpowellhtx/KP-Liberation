#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_units

    File: fn_hudSM_onReportFob_units.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:09:49
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
        , {MPARAM(_onReportFob_units_debug)}
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
    [format ["[fn_hudSM_onReportFob_units] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    [
        _fobs apply { [(_x#4)] call MFUNC(_getFobUnits); }
    ] params [
        Q(_units)
    ];

    [
        [_units apply { count _x; }, { (_this#0); }] call KPLIB_fnc_linq_sum
    ] params [
        Q(_unitsCount)
    ];

    [
        [_unitsCount] call MFUNC(_renderScalar)
        , MVAR(_unitsPath)
    ] params [
        Q(_renderedUnitsCount)
        , Q(_unitsPath)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_unitsCount), _renderedUnitsCount]
        , [QMVAR(_fobReport_unitsPath), _unitsPath]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_units] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
