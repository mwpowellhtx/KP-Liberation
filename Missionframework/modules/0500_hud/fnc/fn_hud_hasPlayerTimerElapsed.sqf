
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_hasPlayerTimerElapsed_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_timerName), KPLIB_hudDispatchSM_dispatchTimer, [""]]
];

private _timer = _player getVariable [_timerName, +KPLIB_timers_default];

private _elapsed = _timer call KPLIB_fnc_timers_hasElapsed;

_elapsed;
