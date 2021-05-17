#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onPostInit

    File: fn_hudSM_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:08:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialziation phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

if (isServer) then {
    ["[fn_hudSM_onPostInit] Initializing...", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
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

    // // // TODO: TBD: reconsider this approach in favor of the sector state machine
    // // // TODO: TBD: which should have the counts readily available...
    // // // TODO: TBD: the only missing part then would be to align players with the nearest sectors
    // // Rinse and repeat, register several SECTOR report callbacks
    // [MVAR(_reportSector), MFUNC(_onReportSector_captured)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_engaged)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_gridref)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_markerText)] call CBA_fnc_addEventHandler;
    // [MVAR(_reportSector), MFUNC(_onReportSector_progressBar)] call CBA_fnc_addEventHandler;

    // TODO: TBD: there are probably other nuances we can identify based on proximity
    // TODO: TBD: still showing some sort of sector indicator, etc...
    MVAR(_reportSector_callbacks) = [
        MFUNC(_onReportSector_colors)
        , MFUNC(_onReportSector_gridref)
        , MFUNC(_onReportSector_markerText)
        , MFUNC(_onReportSector_progressBar)
        , MFUNC(_onReportSector_timer)
    ];

    // TODO: TBD: and any other reports we may need to deliver...

    // Warm up the server side HUD DISPATCH SM
    [] call MFUNC(_createSM);
};

if (isServer) then {
    ["[fn_hudSM_onPostInit] Initialized", "POST] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
