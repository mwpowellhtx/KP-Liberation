/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-26 22:27:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The module function configuration.

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

// TODO: TBD: there are a couple of HUD 'screens' we want to present, which is downstream from this commit...
// TODO: TBD: separate the FOB resources HUD from the SECTOR engagement HUD
// TODO: TBD: also need better timer support on the SECTOR HUD
// TODO: TBD: we also need to be able to enumerate sectors i.e. when max sectors has been reached.
// TODO: TBD: should be able to present a 'simple' multi-column list view for those sectors, not unlike what we did for the resources
// TODO: TBD: i.e. present one forward list view, and a backing shadow list view, to give it that stood out effect
// TODO: TBD: or perhaps we can add 'shadow' to the text font? TBD...

// class hud {
//     file = "modules\0436_hud\fnc";

//     // Module initialization phase event handler
//     class hud_onPreInit {
//         preInit = 1;
//     };

//     // Module initialization phase event handler
//     class hud_onPostInit {
//         postInit = 1;
//     };

//     // Gets whether the caller should debug
//     class hud_debug {};

//     // Prepares the module settings
//     class hud_settings {};

//     // Setup player actions
//     class hud_setupPlayerActions {};

//     // Checks the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
//     class hud_checkPlayerStatus {};

//     // Conditionally sets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
//     class hud_setPlayerStatus {};

//     // Conditionally unsets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
//     class hud_unsetPlayerStatus {};

//     // Returns whether the elements are in range of each other; favors FOB elements by default
//     class hud_inRange {};

//     // Returns whether the SECTOR elements are in range of each other; designed specifically for SECTOR concerns
//     class hud_sectorInRange {};

//     // Refreshes the specified PLAYER TIMER; prefers DISPATCH, but may specify either
//     class hud_onRefreshPlayerTimer {};

//     // Returns whether the PLAYER TIMER has elapsed; prefers DISPATCH, but may specify either
//     class hud_hasPlayerTimerElapsed {};

//     // HUD overlay 'onLoad' event handler
//     class hud_onLoad {};

//     // FOB CT_LISTNBOX 'onLoad' event handler
//     class hud_lnbFob_onLoad {};

//     // FOB CT_LISTNBOX 'onRefresh' event handler
//     class hud_lnbFob_onRefresh {};

//     // Responds to CBA waited callback
//     class hud_onShow {};

//     // Responds to FOB show CBA waited callbacks
//     class hud_onShowFob {};

//     // Responds to FOB show CBA waited callbacks
//     class hud_onShowSector {};

//     // Reconciles OVERLAY HASHMAP with an incoming DISPATCH REPORT
//     class hud_onReconcileOverlayMap {};

//     // Gets the OVERLAY VALUES corresponding to the known HUDDISPATCHSM view data keys
//     class hud_getFobViewData {};

//     // SECTOR HUD overlay 'onLoad' event handler
//     class hudSector_onLoad {};

//     // Gets the VIEW DATA for the caller, very generic, and focused for SECTOR REPORT bits
//     class hudSector_getViewData {};

//     //
//     class hudSector_ctrlsGrpSector_lblProgressBar_onLoad {};

//     //
//     class hudSector_ctrlsGrpSector_lblProgressBar_onRefresh {};

//     //
//     class hudSector_ctrlsGrpSector_lblSectorText_onLoad {};

//     //
//     class hudSector_ctrlsGrpSector_lblSectorText_onRefresh {};

//     //
//     class hudSector_ctrlsGrpSector_lblTimer_onLoad {};

//     //
//     class hudSector_ctrlsGrpSector_lblTimer_onRefresh {};

//     // SECTOR HUD progressSetPosition API, similar to the primitive
//     class hudSector_ctrlsGrpSector_progressSetPosition {};
// };

// // TODO: TBD: walking away from server side SM...
// class hudSM {
//     file = "modules\0436_hud\statemachine";

//     // Module initialization phase event handler
//     class hudSM_onPreInit {
//         preInit = 1;
//     };

//     // Module initialization phase event handler
//     class hudSM_onPostInit {
//         postInit = 1;
//     };

//     // Returns whether the caller should perform debugging
//     class hudSM_debug {};

//     // Initializes the module settings
//     class hudSM_settings {};

//     // Creates the CBA HUD DISPATCH state machine and initializes
//     class hudSM_createSM {};

//     // Event handler responding to stacked 'PlayerConnected' events
//     class hudSM_onPlayerConnected {};

//     // Event handler responding to stacked 'PlayerDisconnected' events
//     class hudSM_onPlayerDisconnected {};

//     // Returns the next iteration of the HUD DISPATCH state machine list
//     class hudSM_onGetList {};

//     // Performs a no-op for use when tracing and troubleshooting the HUD DISPATCH statemachine
//     class hudSM_onNoOp {};

//     //
//     class hudSM_onStandbyEntered {};

//     // STANDBY 'onState' event handler, briefs PLAYER with next REPORT and STATUS
//     class hudSM_onStandby {};

//     // Compiles the next STATUS REPORT 'onTransition' between STANDBY and DISPATCH
//     class hudSM_onCompileReport {};

//     // Creates a REPORT CONTEXT for use throughout the report callbacks
//     class hudSM_createReportContext {};

//     // Initializes a REPORT CONTEXT for FOB usage
//     class hudSM_onCreateReportContext_initFob {};

//     // Initializes a REPORT CONTEXT for SECTOR usage
//     class hudSM_onCreateReportContext_initSector {};

//     // Dispatches the STANDBY REPORT to the target PLAYER when there is something different to report
//     class hudSM_onDispatchEntered {};

//     // Returns the ASSETS in RANGE of the FOBs that SHOULD be COUNTED
//     class hudSM_getFobAssets {};

//     // Returns UNITS within RANGE of a POSITION; default scenario is in range of FOB
//     class hudSM_getUnits {};

//     //
//     class hudSM_getFobUnits {};

//     // Returns UNITS within RANGE of POSITION aligned to a given SIDE
//     class hudSM_getSectorUnits {};

//     // Renders the SCALAR in a flexible manner
//     class hudSM_renderScalar {};

//     // Scans [CONDITION, COLOR] tuple array for the first CONDITION and returns its COLOR, default is BLACK
//     class hudSM_getThresholdColor {};

//     // Compiles a FOB REPORT targeting ASSET counts
//     class hudSM_onReportFob_assets {};

//     // Compiles a FOB REPORT targeting enemy AWARENESS and STRENGTH ratings, includes rendered PERCENTAGE and COLOR
//     class hudSM_onReportFob_enemy {};

//     // Compiles a FOB REPORT targeting CIVILIAN REPUTATION, includes COLOR
//     class hudSM_onReportFob_civRep {};

//     // Compiles a FOB REPORT targeting INTEL, includes COLOR
//     class hudSM_onReportFob_intel {};

//     // Compiles a FOB REPORT targeting MARKER TEXT
//     class hudSM_onReportFob_markerText {};

//     // Compiles a FOB REPORT targeting RESOURCE counts
//     class hudSM_onReportFob_resources {};

//     // Compiles a FOB REPORT targeting non player UNIT count
//     class hudSM_onReportFob_units {};

//     //
//     class hudSM_onReportSector_colors {};

//     // Compiles a SECTOR REPORT targeting GRIDREF
//     class hudSM_onReportSector_gridref {};

//     // Compiles a SECTOR REPORT targeting MARKER TEXT
//     class hudSM_onReportSector_markerText {};

//     // Compiles a SECTOR REPORT tarting PROGRESS BAR POSITION
//     class hudSM_onReportSector_progressBar {};

//     //
//     class hudSM_onReportSector_timer {};
// };

// TODO: TBD: migrating toward client side WAE style event loops...
class hudFob {
    file = "modules\0436_hud\hudFob";

    // Arranges for module preset variables
    class hudFob_presets {};

    // Arranges for module settings variables
    class hudFob_settings {};

    // Initialization phase event handler
    class hudFob_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class hudFob_onPostInit {
        postInit = 1;
    };

    // Returns the next FOB HUD report object
    class hudFob_getReport {};

    // Fleshes out the next REPORT and directs HUD resource attention
    class hudFob_onReport {};

    // Populates the ROTARY+FIXED+WING ASSET features of the FOB HUD report
    class hudFob_onReportAssets {};

    // Populates the CIVILIAN REPUTATION features of the FOB HUD report
    class hudFob_onReportCivilian {};

    // Populates the ENEMY STRENGTH+AWARENESS features of the FOB HUD report
    class hudFob_onReportEnemy {};

    // Populates the FRIENDLY features of the FOB HUD report
    class hudFob_onReportFriendly {};

    // Populates the INTEL features of the FOB HUD report
    class hudFob_onReportIntel {};

    // Populates the FOB|ALL RESOURCES features of the FOB HUD report
    class hudFob_onReportResources {};

    // Renders each of the constituent RECORD VALUES accordingly
    class hudFob_renderSimple {};

    // Sets up module PLAYER actions
    class hudFob_setupPlayerActions {};

    // Assembles the VIEW DATA corresponding to the REPORT MAP
    class hudFob_getViewData {};

    // Renders one of the REPORT RECORD features using entirely meta details
    class hudFob_getViewDatum {};

    // Returns a table of ENEMY THRESHOLDS used to color enemy FOB HUD bits
    class hudFob_getEnemyThresholds {};

    // Returns a table of CIVILIAN REPUTATION THRESHOLDS used to color civilian FOB HUD bits
    class hudFob_getCivRepThresholds {};

    // Returns the COLOR corresponding to the given RATIO and aligning table
    class hudFob_getThresholdColor {};

    // FOB HUD onLoad event handler
    class hudFobUI_onLoad {};

    // FOB HUD LISTNBOX onLoad event handler
    class hudFobUI_lnbFob_onLoad {};

    // FOB HUD LISTNBOX onRefresh event handler
    class hudFobUI_lnbFob_onRefresh {};
};
