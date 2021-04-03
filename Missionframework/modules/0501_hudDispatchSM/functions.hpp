/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameters:
        ...

    Returns:
        ...

    References:
        ...
 */

class hudDispatchSM {
    file = "modules\0501_hudDispatchSM\fnc";

    // Module initialization phase event handler
    class hudDispatchSM_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class hudDispatchSM_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should perform debugging
    class hudDispatchSM_debug {};

    // Initializes the module settings
    class hudDispatchSM_settings {};

    // Creates the CBA HUD DISPATCH state machine and initializes
    class hudDispatchSM_createSM {};

    // Event handler responding to stacked 'PlayerConnected' events
    class hudDispatchSM_onPlayerConnected {};

    // Event handler responding to stacked 'PlayerDisconnected' events
    class hudDispatchSM_onPlayerDisconnected {};

    // Returns the next iteration of the HUD DISPATCH state machine list
    class hudDispatchSM_onGetList {};

    // Performs a no-op for use when tracing and troubleshooting the HUD DISPATCH statemachine
    class hudDispatchSM_onNoOp {};

    //
    class hudDispatchSM_onStandbyEntered {};

    // STANDBY 'onState' event handler, briefs PLAYER with next REPORT and STATUS
    class hudDispatchSM_onStandby {};

    // Compiles the next STATUS REPORT 'onTransition' between STANDBY and DISPATCH
    class hudDispatchSM_onCompileReport {};

    // Creates a REPORT CONTEXT for use throughout the report callbacks
    class hudDispatchSM_createReportContext {};

    // Initializes a REPORT CONTEXT for FOB usage
    class hudDispatchSM_onCreateReportContext_initFob {};

    // Initializes a REPORT CONTEXT for SECTOR usage
    class hudDispatchSM_onCreateReportContext_initSector {};

    // Dispatches the STANDBY REPORT to the target PLAYER when there is something different to report
    class hudDispatchSM_onDispatchEntered {};

    // Returns the ASSETS in RANGE of the FOBs that SHOULD be COUNTED
    class hudDispatchSM_getFobAssets {};

    // If an ASSET can be PERSISTED, then it SHOULD be COUNTED
    class hudDispatchSM_whereShouldBeCounted {};

    // Returns UNITS within RANGE of a POSITION; default scenario is in range of FOB
    class hudDispatchSM_getUnits {};

    //
    class hudDispatchSM_getFobUnits {};

    // Returns UNITS within RANGE of POSITION aligned to a given SIDE
    class hudDispatchSM_getSectorUnits {};

    // Renders the SCALAR in a flexible manner
    class hudDispatchSM_renderScalar {};

    // Scans [CONDITION, COLOR] tuple array for the first CONDITION and returns its COLOR, default is BLACK
    class hudDispatchSM_getThresholdColor {};

    // Compiles a FOB REPORT targeting ASSET counts
    class hudDispatchSM_onReportFob_assets {};

    // Compiles a FOB REPORT targeting enemy AWARENESS and STRENGTH ratings, includes rendered PERCENTAGE and COLOR
    class hudDispatchSM_onReportFob_enemy {};

    // Compiles a FOB REPORT targeting CIVILIAN REPUTATION, includes COLOR
    class hudDispatchSM_onReportFob_civRep {};

    // Compiles a FOB REPORT targeting INTEL, includes COLOR
    class hudDispatchSM_onReportFob_intel {};

    // Compiles a FOB REPORT targeting MARKER TEXT
    class hudDispatchSM_onReportFob_markerText {};

    // Compiles a FOB REPORT targeting RESOURCE counts
    class hudDispatchSM_onReportFob_resources {};

    // Compiles a FOB REPORT targeting non player UNIT count
    class hudDispatchSM_onReportFob_units {};

    //
    class hudDispatchSM_onReportSector_colors {};

    // Compiles a SECTOR REPORT targeting GRIDREF
    class hudDispatchSM_onReportSector_gridref {};

    // Compiles a SECTOR REPORT targeting MARKER TEXT
    class hudDispatchSM_onReportSector_markerText {};

    // Compiles a SECTOR REPORT tarting PROGRESS BAR POSITION
    class hudDispatchSM_onReportSector_progressBar {};

    //
    class hudDispatchSM_onReportSector_timer {};
};
