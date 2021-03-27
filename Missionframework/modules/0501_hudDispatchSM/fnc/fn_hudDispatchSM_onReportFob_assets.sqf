#include "script_component.hpp"

private _debug = [
    [
        {MPARAM(_onReportFob_assets_debug)}
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

if (count _fobs > 0) then {
    [
        _fobs apply { [_x] call MFUNC(_getFobAssets); }
        , _fobs apply { [_x, Q(Helicopter)] call MFUNC(_getFobAssets); }
    ] params [
        Q(_fixedWingAssets)
        , Q(_rotaryAssets)
    ];
    _report append [
        [QMVAR(_fobReport_rotaryWingCount), [_rotaryAssets apply { count _x; }] call KPLIB_fnc_linq_sum]
        , [QMVAR(_fobReport_fixedWingCount), [_fixedWingAssets apply { count _x; }] call KPLIB_fnc_linq_sum]
    ];
};

_context setVariable [Q(_compiledReport), _report];

true;
