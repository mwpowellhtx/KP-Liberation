#include "script_component.hpp"

// ...

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
    [format ["[fn_hudDispatchSM_onReportFob_civReputation] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    // TODO: TBD: may want to refactor in terms of uniform preset settings...
    [
        KPLIB_civilian_civRep
        , KPLIB_param_civilian_maxCivRep
        , -(3.4 * abs KPLIB_civilian_civRepBaseThreshold)
        , -(2.6 * abs KPLIB_civilian_civRepBaseThreshold)
        , -(abs KPLIB_civilian_civRepBaseThreshold)
        , (abs KPLIB_civilian_civRepBaseThreshold)
        , (2 * abs KPLIB_civilian_civRepBaseThreshold)
        , "%"
    ] params [
        Q(_civRep)
        , Q(_maxCivRep)
        , Q(_hostileThreshold)
        , Q(_disfavorThreshold)
        , Q(_dislikeThreshold)
        , Q(_likeThreshold)
        , Q(_favoredThreshold)
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
        [(abs _civRep), _maxCivRep, _suffix] call MFUNC(_renderScalar)
        , [_civRepRatio, [
            [_favoredThreshold, _greenColor]
            , [_likeThreshold, _blueColor]
            , [_dislikeThreshold, _whiteColor]
            , [_disfavorThreshold, _yellowColor]
            , [_hostileThreshold, _orangeColor]], _redColor] call MFUNC(_getThresholdColor)
    ] params [
        Q(_renderedCivRep)
        , Q(_civRepColor)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_civRep), _renderedCivRep]
        , [QMVAR(_fobReport_civRepColor), _civRepColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_civReputation] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
