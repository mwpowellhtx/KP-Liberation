#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/splitString
// https://community.bistudio.com/wiki/trim

private _debug = [
    [
        {MPARAM(_onReportSector_debug)}
        , {MPARAM(_onReportSector_markerText_debug)}
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
    [format ["[fn_hudDispatchSM_onReportSector_markerText] Entering: [_markerName]: %1"
        , str [_markerName]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: really should refactor these key elements to its own sectors module
// Factories include a CAPABILITY suffix
private _normalizeFactory = {
    params [
        [Q(_markerText), "", [""]]
    ];
    // Split string only when there is a delim
    if (_markerText find "[" < 0) then { _markerText; } else {
        trim ((_markerText splitString "[")#0);
    };
};

// Radio towers include a GRIDREF prefix
private _normalizeTower = {
    params [
        [Q(_markerText), "", [""]]
    ];
    // Split string only when there is a delim
    if (_markerText find "-" < 0) then { _markerText; } else {
        trim ((_markerText splitString "-")#1);
    };
};

if (!(_markerName isEqualTo "")) then {

    [
        // Normalize for FACTORY and TOWER SECTOR marker texts
        [[markerText _markerName] call _normalizeFactory] call _normalizeTower
    ] params [
        Q(_markerText)
    ];

    _compiledReport append [
        [QMVAR(_sectorReport_markerText), _markerText]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_markerText] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
