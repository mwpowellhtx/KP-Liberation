#include "script_component.hpp"

// ...

if (isServer) then {
    // TODO: TBD: add logging
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init

    // Setup some player actions
    [] call MFUNC(_setupPlayerActions);
};

if (isServer) then {
    // TODO: TBD: add logging
};

true;
