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

    ["KPLIB_player_redeploy", {
        params [
            [Q(_player), objNull, [objNull]]
        ];
        // Clear out the HUD OVERLAY variables on REDEPLOY, allows for a next cut to occur
        _player setVariable [QMVAR(_lastStatusReportAction), nil];
    }] call CBA_fnc_addEventHandler;

    // Setup some player actions
    [] call MFUNC(_setupPlayerActions);
};

if (hasInterface) then {
    ["[fn_hud_onPostInit] Finished", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

true;
