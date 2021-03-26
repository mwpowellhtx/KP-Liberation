#include "script_component.hpp"

// ...

if (isServer) then {
    ["[fn_hudDispatchSM_onPostInit] Initializing...", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    // Respond to player connection events
    addMissionEventHandler [MVAR(_playerConnected), MFUNC(_onPlayerConnected)];
    addMissionEventHandler [MVAR(_playerDisconnected), MFUNC(_onPlayerDisconnected)];

    // Warm up the server side HUD DISPATCH SM
    [] call MFUNC(_createSM);
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPostInit] Initialized", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
