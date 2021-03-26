
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

    // STANDBY 'onState' event handler, briefs PLAYER with next REPORT and STATUS
    class hudDispatchSM_onStandby {};

    //
    class hudDispatchSM_onDispatch {};

    // Returns the ASSETS in RANGE of the FOBs that SHOULD be COUNTED
    class hudDispatchSM_getFobAssets {};

    // If an ASSET can be PERSISTED, then it SHOULD be COUNTED
    class hudDispatchSM_whereShouldBeCounted {};

    // Returns UNITS within RANGE of a POSITION; default scenario is in range of FOB
    class hudDispatchSM_getUnits {};

    // Returns UNITS within RANGE of POSITION aligned to a given SIDE
    class hudDispatchSM_getSectorUnits {};

    // Compiles a player specific FOB report for dispatch
    class hudDispatchSM_onReportFob {};

    // Compiles a player specific SECTOR report for dispatch
    class hudDispatchSM_onReportSector {};
};
