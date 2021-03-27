#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_hudDispatchSM_onStandbyEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudDispatchSM_onStandbyEntered] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Starts running a new timer with every cycle
_player setVariable [QMVAR(_dispatchTimer), [MPARAM(_dispatchPeriod)] call KPLIB_fnc_timers_create];

if (_debug) then {
    ["[fn_hudDispatchSM_onStandbyEntered] Fini", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
