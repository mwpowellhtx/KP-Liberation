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

// Having already deduced whether PLAYER requesting ONE or ALL FOB zones
switch (count _fobs) do {
    case 0: {
        // No-op, nothing to report
    };
    case 1: {
        _compiledReport append [
            [QMVAR(_fobReport_markerText), (_fobs#0#1)]
        ];
    };
    default {
        // TODO: TBD: relay through string table...
        _compiledReport append [
            [QMVAR(_fobReport_markerText), "All FOBs"]
        ];
    };
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_markerText] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
