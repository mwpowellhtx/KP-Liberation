#include "script_component.hpp"

// ...

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
    [format ["[fn_hudDispatchSM_onReportFob_intel] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// FOBs being the key ingredient
if (count _fobs > 0) then {

    [
        KPLIB_resources_intel
        , +KPLIB_preset_common_intelColor
        , KPLIB_preset_common_intelPath
    ] params [
        Q(_intel)
        , Q(_intelColor)
        , Q(_intelPath)
    ];

    [
        [_intel] call KPLIB_fnc_hudDispatch_renderScalar
    ] params [
        Q(_renderedIntel)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_intel), _renderedIntel]
        , [QMVAR(_fobReport_intelPath), KPLIB_preset_common_intelPath]
        , [QMVAR(_fobReport_intelColor), +KPLIB_preset_common_intelColor]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_intel] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
