#include "script_component.hpp"

// ...

private _objSM = MVAR(_objSM);

// Probably do not need to set the variable on the statemachine object
private _players = _objSM getVariable [QMVAR(_players), allPlayers];

// Do not refresh timers etc at this moment
_players;
