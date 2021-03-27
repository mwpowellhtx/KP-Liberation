#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onCompileReport_debug)}
    ]
] call MFUNC(_debug);

// ...
// https://community.bistudio.com/wiki/setVariable#Alternative_Syntax

params [
    [Q(_player), objNull, [objNull]]
];

// Create the REPORT CONTEXT and raise the REPORT EVENTS
private _context = [] call MFUNC(_createReportContext);

// Even though this should already be on SERVER, make sure it is
[[MVAR(_reportFob), MVAR(_reportSector)], [_player, _context]] call {
    params [
        [Q(_eventNames), [], [[]]]
        , [Q(_args), [], [[]]]
    ];
    {
        private _eventName = _x;
        [_x, _args] call CBA_fnc_serverEvent;
    } forEach _eventNames;
};

[
    KPLIB_hud_status_standby
    , _context getVariable [MVAR(_compiledReport), []]
    , QMVAR(_standbyStatus)
    , QMVAR(_standbyReport)
] params [
    Q(_compiledStatus)
    , Q(_compiledReport)
    , Q(_standbyStatus)
    , Q(_standbyReport)
];

{ _player setVariable _x; } forEach [
    [_standbyStatus, _compiledStatus]
    , [_standbyReport, +_compiledReport]
]

// Safe to GC the CONTEXT now
[_context] call KPLIB_fnc_namespace_onGC;

[
    { [(_x#0), MVAR(_fobReportPrefix)] call KPLIB_fnc_string_startsWith; } count _compiledReport
    , { [(_x#0), MVAR(_sectorReportPrefix)] call KPLIB_fnc_string_startsWith; } count _compiledReport
    , KPLIB_hud_status_fob
    , KPLIB_hud_status_sector
] params [
    Q(_fobReportCount)
    , Q(_sectorReportCount)
    , Q(_fob)
    , Q(_sector)
];

// Looks very similar to the STANDBY SNIFF, make it official with a REPRRT COUNT
[_compiledStatus, _fob, { _fobReportCount > 0; }, _standbyStatus] call KPLIB_fnc_hud_setPlayerStatus;
[_compiledStatus, _fob, { _fobReportCount == 0; }, _standbyStatus] call KPLIB_fnc_hud_unsetPlayerStatus;

[_compiledStatus, _sector, { _sectorReportCount > 0; }, _standbyStatus] call KPLIB_fnc_hud_setPlayerStatus;
[_compiledStatus, _sector, { _sectorReportCount == 0; }, _standbyStatus] call KPLIB_fnc_hud_unsetPlayerStatus;

// Then relay the bits for DISPATCH consideration
{ _player setVariable _x; } forEach [
    [_standbyReport, _compiledReport]
    [_standbyStatus, _compiledStatus]
];

true;
