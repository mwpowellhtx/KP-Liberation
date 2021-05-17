/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:20:59
    Last Update: 2021-05-17 15:42:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class missions {
    file = "modules\0904_missions\fnc";

    // Module initialization phase event handler
    class missions_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missions_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should do some debugging
    class missions_debug {};

    // CBA Settings initialization for this module
    class missions_settings {};

    // Creates a CBA MISSION TEMPLATE namespace
    class missions_createTemplate {};

    // Clones the given CBA MISSION as a new namespace; typically based on a TEMPLATE
    class missions_cloneMission {};

    // Registers ONE MISSION TEMPLATE
    class missions_registerOne {};

    // Registers zero or more MISSION TEMPLATES
    class missions_registerMany {};

    // Returns the configured REBATE VALUE
    class missions_getRebateValue {};

    // Returns the MISSIONS LISTS, first one are MISSION TEMPLATES, second are the RUNNING MISSIONS
    class missions_onGetLists {};

    // Returns the MISSION corresponding to the 'uuid' and 'templateUuid'
    class missions_getMissionByUuid {};

    // Module mission data serialization event handler
    class missions_onLoadData {};

    // Module mission data serialization event handler
    class missions_onSaveData {};

    // Returns a human readable status report based on the MISSION STATUS bit flags
    class mission_getStatusReport {};

    // Sets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class mission_setStatus {};

    // Unsets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class mission_unsetStatus {};

    // Checks the STATUS of either the raw target, or variable in the CBA MISSION namespace
    class mission_checkStatus {};

    // Returns whether the raw or CBA MISSION namespace hosted TIMER has elapsed
    class mission_timerHasElapsed {};

    // A no-op placeholder callback used throughout the state machine and missions framework.
    class mission_onNoOp {};

    // No-op default setup callback, returns KPLIB_mission_status_started
    class mission_onNoOpSetup {};

    // No-op default mission callback, returns KPLIB_mission_status_standby
    class mission_onNoOpMission {};

    // No-op default tear down callback, returns KPLIB_mission_status_completed
    class mission_onNoOpTearDown {};

    // Returns a default set of TELEMETRY, or as specified by the CBA MISSION namespace
    class mission_onNoOpTelemetry {};

    // Returns the TELEMETRY corresponding to the TUPLE ARRAY form factor
    class mission_getArrayTelemetry {};

    // Transforms the CBA MISSION namespace to TUPLE ARRAY form factor useful for missions manager clients
    class mission_namespaceToArray {};

    // Notifies specified players attached to the MISSION, or all players, but not the server
    class mission_onNotify {};

    // Performs routine GARBAGE COLLECTION on the TARGET MISSION
    class mission_onGC {};
};

class missionsSM {
    file = "modules\0904_missions\statemachine";

    // Module initialization phase event handler
    class missionsSM_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsSM_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should perform debugging
    class missionsSM_debug {};

    // CBA Settings initialization for this module
    class missionsSM_settings {};

    // Creates a CBA missions state machine
    class missionsSM_createSM {};

    // Returns the array of RUNNING MISSIONS for use with the state machine
    class missionsSM_onGetList {};

    // Default no-op state machine callback, used to help trace through the states and transitions
    class missionsSM_onNoOp {};

    // Callback connects the dots with MISSION MANAGER when opened
    class missionsSM_onMissionsMgrOpened {};

    // Callback disconnects the dots from MISSION MANAGER with closed
    class missionsSM_onMissionsMgrClosed {};

    // Broadcasts the MISSIONS to listening MISSION MANAGER players
    class missionsSM_onBroadcast {};

    // Publishes the MISSIONS to one listening MISSION MANAGER player
    class missionsSM_onPublish {};

    // A default CBA MISSIONS 'onState' facilitator: 'setup', 'mission', 'tearDown'
    class missionsSM_onState {};

    // A default CBA MISSIONS 'onStateEntered' or 'onStateLeaving' facilitator: 'setup', 'tearDown', 'complete'
    class missionsSM_onTransition {};
};

class missionsCO {
    file = "modules\0904_missions\changeOrders";

    // Module initialization phase event handler
    class missionsCO_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsCO_onPostInit {
        postInit = 1;
    };

    //
    class missionsCO_debug {};

    // Responds to client 'onRequest' server events
    class missionsCO_onRequest {};

    // Responds to client 'onRequest::run' server events
    class missionsCO_onRequestRun {};

    // Responds to client 'onRequest::abort' server events
    class missionsCO_onRequestAbort {};
};

class missionsMgr {
    file = "modules\0904_missions\ui";

    // Module initialization phase event handler
    class missionsMgr_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsMgr_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should perform debugging
    class missionsMgr_debug {};

    // Initialization of actions available to players
    class missionsMgr_setupPlayerActions {};

    // Opens the missions manager dialog
    class missionsMgr_openDialog {};

    // Dialog 'onLoad' event handler
    class missionsMgr_onLoad {};

    // Dialog 'onUnload' event handler
    class missionsMgr_onUnload {};

    // RUN and ABORT CT_BUTTON 'onButtonClick' event handlers
    class missionsMgr_btnRequest_onButtonClick {};

    // ABORT CT_BUTTON 'onLoad' event handler
    class missionsMgr_btnAbort_onLoad {};

    // RUN CT_BUTTON 'onLoad' event handler
    class missionsMgr_btnRun_onLoad {};

    // Calculates which controls should be enabled or disabled
    class missionsMgr_calculateEnabledOrDisabled {};

    // MISSION TITLE LBL 'onLoad' event handler
    class missionsMgr_lblMissionTitle_onLoad {};

    //
    class missionsMgr_lblMissionTitle_onRefresh {};

    //
    class missionsMgr_lblMissionTitle_toViewData {};

    //
    class missionsMgr_imgBriefing_onLoad {};

    //
    class missionsMgr_imgBriefing_onRefresh {};

    //
    class missionsMgr_imgBriefing_toViewData {};

    // Reads the data backing the MISSIONS LISTNBOX selected row
    class missionsMgr_lnbMissions_getData {};

    // MISSIONS LISTNBOX 'onLBSelChanged' event handler
    class missionsMgr_lnbMissions_onLBSelChanged {};

    //
    class missionsMgr_lnbMissions_onLoadDummy {};

    //
    class missionsMgr_lnbMissions_onLoad {};

    //
    class missionsMgr_lnbMissions_onRefresh {};

    //
    class missionsMgr_lnbMissions_toViewData {};

    //
    class missionsMgr_lnbTelemetry_getViewKeys {};

    //
    class missionsMgr_lnbTelemetry_onLoadDummy {};

    //
    class missionsMgr_lnbTelemetry_onLoad {};

    //
    class missionsMgr_lnbTelemetry_onRefresh {};

    // TELEMETRY LISTNBOX 'onLBSelChanged' event handler
    class missionsMgr_lnbTelemetry_onLBSelChanged {};

    //
    class missionsMgr_lnbTelemetry_toViewData {};

    //
    class missionsMgr_onMissionsPublished {};

    //
    class missionsMgr_ctBriefing_onLoad {};

    //
    class missionsMgr_ctBriefing_onLoadDummy {};

    //
    class missionsMgr_ctBriefing_onLoadPrototype {};

    //
    class missionsMgr_ctBriefing_onRefresh {};

    //
    class missionsMgr_ctBriefing_toViewData {};
};
