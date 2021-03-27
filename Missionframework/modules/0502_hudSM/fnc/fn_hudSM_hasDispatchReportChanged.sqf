#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_hasDispatchReportChanged_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// Simply lift whether OVERLAY CHANGED, see also: STANDBY event handler
_player getVariable [QMVAR(_overlayChanged), false];
