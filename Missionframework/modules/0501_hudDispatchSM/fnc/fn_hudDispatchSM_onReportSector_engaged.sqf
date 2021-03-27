#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportSector_engaged_debug)}
    ]
] call MFUNC(_debug);

// ...

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

// _markerName is to _fobs as SECTOR report is to FOB report
[
    _context getVariable [Q(_markerName), ""]
    , _context getVariable [Q(_actualRange), 0]
    , _context getVariable [Q(_targetRange), 0]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_markerName)
    , Q(_actualRange)
    , Q(_targetRange)
    , Q(_report)
];

if (!(_markerName isEqualTo "")) then {
    _report append [
        [QMVAR(_sectorReport_engaged), _actualRange >= 0 && _actualRange <= _targetRange]
    ];
};

_context setVariable [Q(_compiledReport), _report];

true;
