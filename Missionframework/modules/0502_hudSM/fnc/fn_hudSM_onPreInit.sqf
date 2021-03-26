#include "script_component.hpp"

// ...

if (hasInterface) then {
    // TODO: TBD: add logging
};

// Setup client side HUD SM settings
[] call MFUNC(_settings);

MVAR(_updatePlayer)                     = QMVAR(_updatePlayer);

if (hasInterface) then {
    // Client side init

    MVAR(_className)                    = Q(KPLIB_hudSM);

    MVAR(_objSM)                        = locationNull;
    MVAR(_configSM)                     = configNull;
};

if (hasInterface) then {
    // TODO: TBD: add logging
};

true;
