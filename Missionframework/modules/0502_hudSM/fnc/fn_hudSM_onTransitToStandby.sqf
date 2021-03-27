#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onTransitToStandby_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// Clear out the OVERLAY TIMER anticipating the next refresh cycle
_player setVariable [MVAR(_overlayTimer), nil];

systemChat "[fn_hudSM_onTransitToStandby] Fini";

true;
