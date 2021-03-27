#include "script_component.hpp"

// ...

if (hasInterface) then {
    ["[fn_hudSM_onPreInit] Initializing...", "PRE] [HUDSM", true] call KPLIB_fnc_common_log;
};

// Setup client side HUD SM settings
[] call MFUNC(_settings);

MVAR(_updatePlayer)                     = QMVAR(_updatePlayer);

if (hasInterface) then {
    // Client side init

    MVAR(_className)                    = Q(KPLIB_hudSM);

    MVAR(_objSM)                        = locationNull;
    MVAR(_configSM)                     = configNull;

    MLAYER(_fob)                        = QMLAYER(_fob);
    MLAYER(_sector)                     = QMLAYER(_sector);

    MVAR(_overlayTimer)                 = QMVAR(_overlayTimer);
    //MVAR(_overlayTimerElapsed)          = QMVAR(_overlayTimerElapsed);
};

if (hasInterface) then {
    ["[fn_hudSM_onPreInit] Initialized", "PRE] [HUDSM", true] call KPLIB_fnc_common_log;
};

true;
