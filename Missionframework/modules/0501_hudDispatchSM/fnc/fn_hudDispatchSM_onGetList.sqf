#include "script_component.hpp"

// ...

private _objSM = MVAR(_objSM);

// Probably do not need to set the variable on the statemachine object
private _players = _objSM getVariable [QMVAR(_players), allPlayers];

private _defaultTimer = [MPARAM(_dispatchPeriod)] call KPLIB_fnc_timers_create;

{
    private _player = _x;
    // Make sure player has a running dispatch timer
    private _timer = _player getVariable [QMVAR(_dispatchTimer), _defaultTimer];
    _player setVariable [QMVAR(_dispatchTimer), _timer];
} forEach _players;

_players;
