#include "script_component.hpp"

// ...

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
    _context getVariable [Q(_fobs), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_markerText] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Deduced player requesting ONE or ALL, 0) no report, 1) ONE FOB, 2+) ALL FOBS
private _markerText = switch (count _fobs) do {
    case 0: { ""; };
    case 1: { (_fobs#0#1); };
    default { "All FOBs"; };
};

// Now report MARKER TEXT and corresponding COLOR
if (!(_markerText isEqualTo "")) then {
    _compiledReport append [
        [QMVAR(_fobReport_markerText), toUpper _markerText]
        , [QMVAR(_fobReport_markerColor), KPLIB_core_fobColor]
        , [QMVAR(_fobReport_markerPath), KPLIB_core_fobMarkerPath]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_markerText] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
