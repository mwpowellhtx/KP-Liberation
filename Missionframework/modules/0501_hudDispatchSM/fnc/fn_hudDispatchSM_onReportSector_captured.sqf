#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportSector_captured_debug)}
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
    , _context getVariable [Q(_bluforSectors), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_markerName)
    , Q(_bluforSectors)
    , Q(_report)
];

if (!(_markerName isEqualTo "")) then {
    _report append [
        [QMVAR(_sectorReport_captured), _markerName in _bluforSectors]
    ];
};

_context setVariable [Q(_compiledReport), _report];

true;
