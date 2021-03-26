#include "script_component.hpp"

// ...

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initializing...", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Setup DISPATCH settings
[] call MFUNC(_settings);

if (isServer) then {
    // Server side init

    MVAR(_className)                    = Q(KPLIB_hudDispatchSM);

    MVAR(_objSM)                        = locationNull;
    MVAR(_configSM)                     = configNull;

    // For use with stackable player connected/disconnected events
    MVAR(_playerConnected)              = Q(PlayerConnected);
    MVAR(_playerDisconnected)           = Q(PlayerDisconnected);
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initialized", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
