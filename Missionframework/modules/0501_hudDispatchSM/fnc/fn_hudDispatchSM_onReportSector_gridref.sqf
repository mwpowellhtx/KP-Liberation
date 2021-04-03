#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onReportSector_debug)}
        , {MPARAM(_onReportSector_gridref_debug)}
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
] params [
    Q(_markerName)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_gridref] Entering: [_markerName]: %1"
        , str [_markerName]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (!(_markerName isEqualTo "")) then {
    _compiledReport append [
        [QMVAR(_sectorReport_gridref), mapGridPosition (markerPos _markerName)]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_gridref] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;