#include "script_component.hpp"

// ...

// TODO: TBD: issue was likely that the CONFIG was not created, the function was not defined
// TODO: TBD: when we have that, it clears up A LOT
// TODO: TBD: sort out the context and I think we'll be okay...
// TODO: TBD: getting ZERO FOBS up front, which does not seem right...
// TODO: TBD: that and we will probably need to run profiler to see what is being called so much

private _debug = [
    [
        {MPARAM(_createReportContext_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// For use throughout, caller assumes responsibility for deletion
private _context = [] call KPLIB_fnc_namespace_create;

// Initialize the CONTEXT with bits that inform FOB and SECTOR reports
[_player, _context] call KPLIB_fnc_hudDispatchSM_onCreateReportContext_initFob;
[_player, _context] call KPLIB_fnc_hudDispatchSM_onCreateReportContext_initSector;

// Reset for a fresh compiled report
_context setVariable [Q(_compiledReport), []];

_context;
