#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportFob_intel_debug)}
    ]
] call MFUNC(_debug);

// ...

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

[
    _context getVariable [MVAR(_fobs), []]
    , _context getVariable [MVAR(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_report)
];

// FOBs being the key ingredient
if (count _fobs > 0) then {
    _report append [
        [QMVAR(_fobReport_intel), KPLIB_resources_intel]
    ];
    _context setVariable [MVAR(_compiledReport), _report];
};

true;
