#include "script_component.hpp"

// ...

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
    _context getVariable [Q(_fobs), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_enemy] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    // TODO: TBD: may want to refactor in terms of uniform preset settings...
    [
        KPLIB_enemy_awareness
        , KPLIB_enemy_strength
        , KPLIB_param_enemy_maxAwareness
        , KPLIB_param_enemy_maxStrength
        , "%"
    ] params [
        Q(_awareness)
        , Q(_strength)
        , Q(_maxAwareness)
        , Q(_maxStrength)
        , Q(_suffix)
    ];

    // TODO: TBD: could these be gradient?
    // TODO: TBD: and preset for that matter
    [
        [0.9, 0, 0, 1]
        , [1, 0.6, 0.2, 1]
        , +KPLIB_core_fobColor
        , (_awareness / _maxAwareness)
        , (_strength / _maxStrength)
    ] params [
        Q(_redColor)
        , Q(_orangeColor)
        , Q(_yellowColor)
        , Q(_awarenessRatio)
        , Q(_strengthRatio)
    ];

    [
        [_awareness, _maxAwareness, _suffix] call KPLIB_fnc_hudDispatchSM_renderScalar
        , [_strength, _maxStrength, _suffix] call KPLIB_fnc_hudDispatchSM_renderScalar
        , [_strengthRatio, [
            [MPRESET(_enemy_high), _redColor]
            , [MPRESET(_enemy_medium), _orangeColor]
            , [MPRESET(_enemy_low), _yellowColor]], _redColor] call MFUNC(_getThresholdColor)
        , [_awarenessRatio, [
            [MPRESET(_enemy_high), _redColor]
            , [MPRESET(_enemy_medium), _orangeColor]
            , [MPRESET(_enemy_low), _yellowColor]], _redColor] call MFUNC(_getThresholdColor)
    ] params [
        Q(_renderedAwareness)
        , Q(_renderedStrength)
        , Q(_renderedAwarenessColor)
        , Q(_renderedStrengthColor)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_awareness), _renderedAwareness]
        , [QMVAR(_fobReport_strength), _renderedStrength]
        , [QMVAR(_fobReport_awarenessColor), _renderedAwarenessColor]
        , [QMVAR(_fobReport_strengthColor), _renderedStrengthColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_enemy] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
