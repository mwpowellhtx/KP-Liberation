
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onRefreshPlayerTimer_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_timerName), KPLIB_hudDispatchSM_dispatchTimer, [""]]
    , [Q(_timerPeriod), KPLIB_hudDispatchSM_dispatchPeriod, [0]]
];

private _defaultTimer = [_timerPeriod] call KPLIB_fnc_timers_create;

private _timer = _player getVariable [_timerName, _defaultTimer];

_timer = _timer call KPLIB_fnc_timers_refresh;

_player setVariable [_timerName, _timer];

// Just refresh the timer that is all
true;
