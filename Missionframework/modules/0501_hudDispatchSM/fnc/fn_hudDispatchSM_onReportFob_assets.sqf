#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onReportFob_assets

    File: fn_hudDispatchSM_onReportFob_assets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
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
        , {MPARAM(_onReportFob_assets_debug)}
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
    [format ["[fn_hudDispatchSM_onReportFob_assets] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (count _fobs > 0) then {

    [
        _fobs apply { [_x, Q(Helicopter)] call MFUNC(_getFobAssets); }
        , _fobs apply { [_x] call MFUNC(_getFobAssets); }
    ] params [
        Q(_fobRotaryAssets)
        , Q(_fobFixedWingAssets)
    ];

    [
        [_fobRotaryAssets apply { count _x; }] call KPLIB_fnc_linq_sum
        , [_fobFixedWingAssets apply { count _x; }] call KPLIB_fnc_linq_sum
    ] params [
        Q(_rotaryCount)
        , Q(_fixedWingCount)
    ];

    [
        [_rotaryCount] call MFUNC(_renderScalar)
        , [_fixedWingCount] call MFUNC(_renderScalar)
        , MVAR(_rotaryPath)
        , MVAR(_fixedWingPath)
    ] params [
        Q(_renderedRotaryCount)
        , Q(_renderedFixedWingCount)
        , Q(_rotaryPath)
        , Q(_fixedWingPath)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_rotaryCount), _renderedRotaryCount]
        , [QMVAR(_fobReport_fixedWingCount), _renderedFixedWingCount]
        , [QMVAR(_fobReport_rotaryPath), _rotaryPath]
        , [QMVAR(_fobReport_fixedWingPath), _fixedWingPath]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_assets] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
