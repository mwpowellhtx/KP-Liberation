#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportSector_units_debug)}
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
    , _context getVariable [Q(_targetRange), 0]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_markerName)
    , Q(_targetRange)
    , Q(_report)
];

if (!(_markerName isEqualTo "")) then {

    private _markerPos = markerPos _markerName;

    [
        // Yes there are default arguments, but this is clearer
        [_markerPos, KPLIB_preset_sideF, _targetRange] call MFUNC(_getSectorUnits)
        , [_markerPos, KPLIB_preset_sideE, _targetRange] call MFUNC(_getSectorUnits)
        , [_markerPos, KPLIB_preset_sideC, _targetRange] call MFUNC(_getSectorUnits)
        , [_markerPos, KPLIB_preset_sideR, _targetRange] call MFUNC(_getSectorUnits)
    ] params [
        Q(_bluforUnits)
        , Q(_opforUnits)
        , Q(_civilianUnits)
        , Q(_resistanceUnits)
    ];

    _report append [
        [QMVAR(_sectorReport_bluforUnitsCount), count _bluforUnits]
        [QMVAR(_sectorReport_opforUnitsCount), count _opforUnits]
        [QMVAR(_sectorReport_civilianUnitsCount), count _civilianUnits]
        [QMVAR(_sectorReport_resistanceUnitsCount), count _resistanceUnits]
    ];
};

_context setVariable [Q(_compiledReport), _report];

true;
