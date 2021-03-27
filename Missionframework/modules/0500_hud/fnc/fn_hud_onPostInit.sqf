#include "script_component.hpp"

// ...

if (hasInterface) then {
    ["[fn_hud_onPostInit] Entering...", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init

    // Setup some player actions
    [] call MFUNC(_setupPlayerActions);
};

if (hasInterface) then {
    ["[fn_hud_onPostInit] Finished", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

true;
