#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_enemy

    File: fn_hudSM_onReportFob_enemy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 17:40:23
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
        , {MPARAM(_onReportFob_enemy_debug)}
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
    [format ["[fn_hudSM_onReportFob_enemy] Entering: [count _fobMarkers]: %1"
        , str [count _fobMarkers]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobMarkers > 0) then {

    // TODO: TBD: may want to refactor in terms of uniform preset settings...
    [
        0 max (KPLIB_enemies_awareness min KPLIB_param_enemies_maxAwareness)
        , KPLIB_param_enemies_maxAwareness
        , 0 max (KPLIB_enemies_strength min KPLIB_param_enemies_maxStrength)
        , KPLIB_param_enemies_maxStrength
        , "%"
    ] params [
        Q(_awareness)
        , Q(_maxAwareness)
        , Q(_strength)
        , Q(_maxStrength)
        , Q(_suffix)
    ];

    // TODO: TBD: could these be gradient?
    // TODO: TBD: and preset for that matter
    [
        [0.9, 0, 0, 1]
        , [1, 0.6, 0.2, 1]
        // TODO: TBD: if what we want is simply a "yellow" color, then these should be positioned in terms of INIT, CORE, or COMMON modules...
        , +KPLIB_preset_fobs_hudColor
        , [1, 1, 1, 1]
        , (_awareness / _maxAwareness)
        , (_strength / _maxStrength)
    ] params [
        Q(_redColor)
        , Q(_orangeColor)
        , Q(_yellowColor)
        , Q(_whiteColor)
        , Q(_awarenessRatio)
        , Q(_strengthRatio)
    ];

    [
        [_awareness, _maxAwareness, _suffix] call MFUNC(_renderScalar)
        , MVAR(_awarenessRatioPath)
        , [_awarenessRatio, [
            [MPRESET(_enemy_high), _redColor]
            , [MPRESET(_enemy_medium), _orangeColor]
            , [MPRESET(_enemy_low), _yellowColor]], _whiteColor] call MFUNC(_getThresholdColor)
        , [_strength, _maxStrength, _suffix] call MFUNC(_renderScalar)
        , MVAR(_strengthRatioPath)
        , [_strengthRatio, [
            [MPRESET(_enemy_high), _redColor]
            , [MPRESET(_enemy_medium), _orangeColor]
            , [MPRESET(_enemy_low), _yellowColor]], _whiteColor] call MFUNC(_getThresholdColor)
    ] params [
        Q(_renderedAwarenessRatio)
        , Q(_awarenessRatioPath)
        , Q(_awarenessRatioColor)
        , Q(_renderedStrengthRatio)
        , Q(_strengthRatioPath)
        , Q(_strengthRatioColor)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_awareness), _renderedAwarenessRatio]
        , [QMVAR(_fobReport_awarenessPath), _awarenessRatioPath]
        , [QMVAR(_fobReport_awarenessColor), _awarenessRatioColor]
        , [QMVAR(_fobReport_strength), _renderedStrengthRatio]
        , [QMVAR(_fobReport_strengthPath), _strengthRatioPath]
        , [QMVAR(_fobReport_strengthColor), _strengthRatioColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_enemy] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
