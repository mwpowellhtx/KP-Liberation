#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onStandbyEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// Clear out the OVERLAY TIMER anticipating the next refresh cycle
{ _player setVariable _x; } forEach [
    [QMVAR(_overlayTimer), nil]
    , [QMVAR(_overlayChanged), nil]
];

true;
