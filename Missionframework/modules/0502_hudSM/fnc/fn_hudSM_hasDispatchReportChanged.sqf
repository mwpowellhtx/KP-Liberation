#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onBlankEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

[
    _player getVariable [KPLIB_hudDispatchSM_dispatchReport, []]
    , _player getVariable [QMVAR(_overlayReport), []]
] params [
    Q(_dispatchReport)
    , Q(_overlayReport)
];

private _changed = !(_dispatchReport isEqualTo _overlayReport);

if (_changed) then {
    // (Re-)place OVERLAY with the DISPATCH REPORT when CHANGED
    _player setVariable [QMVAR(_overlayReport), +_dispatchReport];
};

// While at the same time reporting CHANGED
_changed;
// Which should leave the OVERLAY REPORT in a position for immediate usage by the OVERLAY state
