#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportFob_units_debug)}
    ]
] call MFUNC(_debug);

// ...

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

[
    _context getVariable [Q(_fobs), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_report)
];

// FOBs being the key ingredient
if (count _fobs > 0) then {
    private _units = _fobs apply { [(_x#4)] call MFUNC(_getUnits); };
    _report append [
        [QMVAR(_fobReport_units), [_units apply { count _x; }] call KPLIB_fnc_linq_sum]
    ];
};

_context setVariable [Q(_compiledReport), _report];

true;
