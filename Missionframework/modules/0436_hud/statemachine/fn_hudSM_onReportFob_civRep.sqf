#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_civRep

    File: fn_hudSM_onReportFob_civRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:09:04
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
        , {MPARAM(_onReportFob_civReputation_debug)}
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
    [format ["[fn_hudSM_onReportFob_civReputation] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    private _civRepThresholdBase = abs KPLIB_param_enemies_civRepBaseThreshold;

    // TODO: TBD: may want to refactor in terms of uniform preset settings...
    [
        [] call KPLIB_fnc_enemies_getCivRepBounded
        , KPLIB_param_enemies_maxCivRep
        , -(3.4 * _civRepThresholdBase)
        , -(2.6 * _civRepThresholdBase)
        , -_civRepThresholdBase
        , _civRepThresholdBase
        , (2 * _civRepThresholdBase)
        , "%"
    ] params [
        Q(_civRep)
        , Q(_maxCivRep)
        , Q(_civRepThresholdHostile)
        , Q(_civRepThresholdDisfavor)
        , Q(_civRepThresholdDislike)
        , Q(_civRepThresholdLike)
        , Q(_civRepThresholdFavored)
        , Q(_suffix)
    ];

    // TODO: TBD: could these be at all gradient?
    // TODO: TBD: and preset for that matter...
    [
        [1, 1, 1, 1]
        , [0.2, 0.6, 1, 1]
        , [0.2, 0.8, 0.2, 1]
        , +KPLIB_core_fobColor
        , [1, 0.6, 0.2, 1]
        , [0.85, 0, 0, 1]
        , (_civRep / _maxCivRep)
    ] params [
        Q(_whiteColor)
        , Q(_blueColor)
        , Q(_greenColor)
        , Q(_yellowColor)
        , Q(_orangeColor)
        , Q(_redColor)
        , Q(_civRepRatio)
    ];

    // TODO: TBD: would be interesting if CIV REP were to 'block' logistics running, even for 'BLUFOR' sectors
    [
        // Yes, 'render' a 'positive' CIV REP, but we will color according to the ACTUAL ratio
        [_civRep, _maxCivRep, _suffix] call MFUNC(_renderScalar)
        , MVAR(_civRepPath)
        , [_civRepRatio, [
            [_civRepThresholdFavored, _greenColor]
            , [_civRepThresholdLike, _blueColor]
            , [_civRepThresholdDislike, _whiteColor]
            , [_civRepThresholdDisfavor, _yellowColor]
            , [_civRepThresholdHostile, _orangeColor]], _redColor] call MFUNC(_getThresholdColor)
    ] params [
        Q(_renderedCivRep)
        , Q(_civRepPath)
        , Q(_civRepColor)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_civRep), _renderedCivRep]
        , [QMVAR(_fobReport_civRepPath), _civRepPath]
        , [QMVAR(_fobReport_civRepColor), _civRepColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_civReputation] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
