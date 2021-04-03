#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onReportSector_debug)}
        , {MPARAM(_onReportSector_timer_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

// _markerName is to _fobs as SECTOR report is to FOB report
[
    _context getVariable [Q(_markerName), ""]
    , _context getVariable [Q(_compiledReport), []]
    // , _context getVariable [Q(_actualRange), 0]
    // , _context getVariable [Q(_targetRange), 0]
] params [
    Q(_markerName)
    , Q(_compiledReport)
    // , Q(_actualRange)
    // , Q(_targetRange)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_engaged] Entering: [_markerName]: %1"
        , str [_markerName]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (!(_markerName isEqualTo "")) then {
    _compiledReport append [
        [QMVAR(_sectorReport_timer), +KPLIB_timers_default]
        // TODO: TBD: color depending on certain thresholds, perhaps a default white, yellow, orange, red
        , [QMVAR(_sectorReport_timerColor), [1, 1, 1, 1]]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_engaged] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
