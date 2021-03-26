#include "script_component.hpp"

// ...
// https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html

if (hasInterface) then {
    // TODO: TBD: add logging
};

if (hasInterface) then {
    // Client side init

    // // TODO: TBD: doubtful we need any special events beyond the setVariable features...
    // [QMVAR(_updatePlayer), MFUNC(_onUpdatePlayer)] call CBA_fnc_addEventHandler;

    // Warm up the client side HUD SM
    [] call MFUNC(_createSM);
};

if (hasInterface) then {
    // TODO: TBD: add logging
};

true;
