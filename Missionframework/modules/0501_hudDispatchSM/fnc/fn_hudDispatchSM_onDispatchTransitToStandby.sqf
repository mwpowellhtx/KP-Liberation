#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onDispatchTransitToStandby_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// TODO: TBD: roll up a fresh status report and determine what the next STATUS should be...

// Clear the timer anticipating the next STANDBY cycle, which REFRESH should RESTART TIMER afresh
_player setVariable [QMVAR(_dispatchTimer), nil];

true;
