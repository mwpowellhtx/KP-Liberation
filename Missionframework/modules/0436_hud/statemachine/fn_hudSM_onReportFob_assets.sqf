#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_assets

    File: fn_hudSM_onReportFob_assets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 17:43:33
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
    _context getVariable [Q(_fobMarkers), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobMarkers)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_assets] Entering: [count _fobMarkers]: %1"
        , str [count _fobMarkers]], "HUDSM", true] call KPLIB_fnc_common_log;
};

if (count _fobMarkers > 0) then {

    [
        _fobMarkers apply { [_x, Q(Helicopter)] call MFUNC(_getFobAssets); }
        , _fobMarkers apply { [_x] call MFUNC(_getFobAssets); }
        , _fobMarkers apply { [_x, KPLIB_preset_slotHeliF] call MFUNC(_getFobAssets); }
        , _fobMarkers apply { [_x, KPLIB_preset_slotJetF] call MFUNC(_getFobAssets); }
    ] params [
        Q(_fobRotaryAssets)
        , Q(_fobFixedWingAssets)
        , Q(_rotarySlotAssets)
        , Q(_fixedWingSlotAssets)
    ];

    [
        [_fobRotaryAssets apply { count _x; }] call KPLIB_fnc_linq_sum
        , [_fobFixedWingAssets apply { count _x; }] call KPLIB_fnc_linq_sum
        , [_rotarySlotAssets apply { count _x; }] call KPLIB_fnc_linq_sum
        , [_fixedWingSlotAssets apply { count _x; }] call KPLIB_fnc_linq_sum
    ] params [
        Q(_rotaryCount)
        , Q(_fixedWingCount)
        , Q(_rotaryCap)
        , Q(_fixedWingCap)
    ];

    [
        [_rotaryCount] call MFUNC(_renderScalar)
        , [_fixedWingCount] call MFUNC(_renderScalar)
        , [_rotaryCap] call MFUNC(_renderScalar)
        , [_fixedWingCap] call MFUNC(_renderScalar)
        , MVAR(_rotaryPath)
        , MVAR(_fixedWingPath)
    ] params [
        Q(_renderedRotaryCount)
        , Q(_renderedFixedWingCount)
        , Q(_renderedRotaryCap)
        , Q(_renderedFixedWingCap)
        , Q(_rotaryPath)
        , Q(_fixedWingPath)
    ];

    // TODO: TBD: server side should be fine: pending client side revisions...
    _compiledReport append [
        [QMVAR(_fobReport_rotaryCount), _renderedRotaryCount]
        , [QMVAR(_fobReport_fixedWingCount), _renderedFixedWingCount]
        , [QMVAR(_fobReport_rotaryCap), _renderedRotaryCap]
        , [QMVAR(_fobReport_fixedWingCap), _renderedFixedWingCap]
        , [QMVAR(_fobReport_rotaryPath), _rotaryPath]
        , [QMVAR(_fobReport_fixedWingPath), _fixedWingPath]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_assets] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
