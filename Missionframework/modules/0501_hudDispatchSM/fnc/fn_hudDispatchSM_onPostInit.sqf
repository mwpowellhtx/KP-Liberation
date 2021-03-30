#include "script_component.hpp"

// ...
// https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
// https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
// https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html

if (isServer) then {
    ["[fn_hudDispatchSM_onPostInit] Initializing...", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    // Respond to player connection events
    addMissionEventHandler [MVAR(_playerConnected), MFUNC(_onPlayerConnected)];
    addMissionEventHandler [MVAR(_playerDisconnected), MFUNC(_onPlayerDisconnected)];

    // // Register several FOB report callbacks
    // [MVAR(_reportFob), MFUNC(_onReportFob_assets)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportFob), MFUNC(_onReportFob_enemy)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportFob), MFUNC(_onReportFob_intel)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportFob), MFUNC(_onReportFob_markerText)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportFob), MFUNC(_onReportFob_resources)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportFob), MFUNC(_onReportFob_units)] call CBA_fnc_addEventHandler;

    // TODO: TBD: did not seem to be accumulating any event-driven reports...
    MVAR(_reportFob_callbacks) = [
        MFUNC(_onReportFob_markerText)
        , MFUNC(_onReportFob_resources)
        , MFUNC(_onReportFob_assets)
        , MFUNC(_onReportFob_intel)
        , MFUNC(_onReportFob_units)
        , MFUNC(_onReportFob_civRep)
        , MFUNC(_onReportFob_enemy)
    ];

    // // Rinse and repeat, register several SECTOR report callbacks
    // [MVAR(_reportSector), MFUNC(_onReportSector_captured)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_engaged)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_gridref)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_markerText)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_tower)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_units)] call CBA_fnc_addEventHandler;
 
    MVAR(_reportSector_callbacks) = [
        MFUNC(_onReportSector_captured)
        , MFUNC(_onReportSector_engaged)
        , MFUNC(_onReportSector_gridref)
        , MFUNC(_onReportSector_markerText)
        , MFUNC(_onReportSector_tower)
        , MFUNC(_onReportSector_units)
    ];

    // TODO: TBD: and any other reports we may need to deliver...

    // Warm up the server side HUD DISPATCH SM
    [] call MFUNC(_createSM);
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPostInit] Initialized", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
