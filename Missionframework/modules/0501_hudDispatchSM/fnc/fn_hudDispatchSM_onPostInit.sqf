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

    // Register several FOB report callbacks
    [MVAR(_reportFob), MFUNC(_onReportFob_assets)] call CBA_fnc_addEventHandler;
    [MVAR(_reportFob), MFUNC(_onReportFob_enemy)] call CBA_fnc_addEventHandler;
    [MVAR(_reportFob), MFUNC(_onReportFob_intel)] call CBA_fnc_addEventHandler;
    [MVAR(_reportFob), MFUNC(_onReportFob_markerText)] call CBA_fnc_addEventHandler;
    [MVAR(_reportFob), MFUNC(_onReportFob_resources)] call CBA_fnc_addEventHandler;
    [MVAR(_reportFob), MFUNC(_onReportFob_units)] call CBA_fnc_addEventHandler;

    // Rinse and repeat, register several SECTOR report callbacks
    [MVAR(_reportSector), MFUNC(_onReportSector_captured)] call CBA_fnc_addEventHandler;
    [MVAR(_reportSector), MFUNC(_onReportSector_engaged)] call CBA_fnc_addEventHandler;
    [MVAR(_reportSector), MFUNC(_onReportSector_gridref)] call CBA_fnc_addEventHandler;
    [MVAR(_reportSector), MFUNC(_onReportSector_markerText)] call CBA_fnc_addEventHandler;
    [MVAR(_reportSector), MFUNC(_onReportSector_tower)] call CBA_fnc_addEventHandler;
    [MVAR(_reportSector), MFUNC(_onReportSector_units)] call CBA_fnc_addEventHandler;

    // TODO: TBD: and any other reports we may need to deliver...

    // Warm up the server side HUD DISPATCH SM
    [] call MFUNC(_createSM);
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPostInit] Initialized", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
