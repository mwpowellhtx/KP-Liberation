
// ...

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

    // Returns UNITS within RANGE of POSITION aligned to a given SIDE
    class hudDispatchSM_getSectorUnits {};

    // Compiles a FOB REPORT targeting ASSET counts [SCALARs]
    class hudDispatchSM_onReportFob_assets {};

    // Compiles a FOB REPORT targeting ENEMY ratings [SCALARs]
    class hudDispatchSM_onReportFob_enemy {};

    // Compiles a FOB REPORT targeting INTEL [SCALAR]
    class hudDispatchSM_onReportFob_intel {};

    // Compiles a FOB REPORT targeting MARKER TEXT [STRING]
    class hudDispatchSM_onReportFob_markerText {};

    // Compiles a FOB REPORT targeting RESOURCE counts [SCALARs]
    class hudDispatchSM_onReportFob_resources {};

    // Compiles a FOB REPORT targeting non player UNIT count [SCALAR]
    class hudDispatchSM_onReportFob_units {};

    // Compiles a SECTOR REPORT targeting whether sector is CAPTURED [BOOL]
    class hudDispatchSM_onReportSector_captured {};

    // Compiles a SECTOR REPORT targeting whether sector is ENGAGED [BOOL]
    class hudDispatchSM_onReportSector_engaged {};

    // Compiles a SECTOR REPORT targeting GRIDREF [STRING]
    class hudDispatchSM_onReportSector_gridref {};

    // Compiles a SECTOR REPORT targeting MARKER TEXT [STRING]
    class hudDispatchSM_onReportSector_markerText {};

    // Compiles a SECTOR REPORT targeting whether marker is TOWER [BOOL]
    class hudDispatchSM_onReportSector_tower {};

    // Compiles a SECTOR REPORT targeting UNIT counts [SCALARs]
    class hudDispatchSM_onReportSector_units {};
};
