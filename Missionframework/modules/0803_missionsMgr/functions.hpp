/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:24:20
    Last Update: 2021-03-19 17:24:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class missionsMgr {
    file = "modules\0803_missionsMgr\fnc";

    // Module initialization phase event handler
    class missionsMgr_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsMgr_onPostInit {
        postInit = 1;
    };

    // Initialization of actions available to players
    class missionsMgr_setupPlayerActions {};

    // Opens the missions manager dialog
    class missionsMgr_openDialog {};

    //// Aborts the given mission
    //class mission_abortMission {};

    //// Selects which mission should be started/aborted and starts th next function
    //class mission_buttonClick {};

    //// Displays the information for the given mission
    //class mission_displayMission {};

    //// Deletes the mission from the running missions
    //class mission_endMission {};

    //// Checks the mission conditions on a changing selection and disables the button
    //class mission_preCheck {};

    //// Starts the given mission or selects one from the given array
    //class mission_startMission {};

    //
    class missionsMgr_btnAbort_onButtonClick {};

    //
    class missionsMgr_btnRun_onButtonClick {};

    //
    class missionsMgr_calculateEnabledOrDisabled {};

    //
    class missionsMgr_imgBriefing_onLoad {};

    //
    class missionsMgr_imgBriefing_onRefresh {};

    //
    class missionsMgr_imgBriefing_toViewData {};

    // Reads the data backing the MISSIONS LISTNBOX selected row
    class missionsMgr_lnbMissions_getData {};

    // !!
    class missionsMgr_lnbMissions_onLBSelChanged {};

    //
    class missionsMgr_lnbMissions_onLoad {};

    //
    class missionsMgr_lnbMissions_onRefresh {};

    //
    class missionsMgr_lnbMissions_toViewData {};

    //
    class missionsMgr_lnbTelemetry_getViewKeys {};

    //
    class missionsMgr_lnbTelemetry_onLoad {};

    //
    class missionsMgr_lnbTelemetry_onRefresh {};

    //
    class missionsMgr_lnbTelemetry_toViewData {};

    //
    class missionsMgr_onLoad {};

    //
    class missionsMgr_onMissionsPublished {};

    //
    class missionsMgr_onUnload {};

    //
    class missionsMgr_txtBriefing_onLoad {};

    //
    class missionsMgr_txtBriefing_onRefresh {};

    //
    class missionsMgr_txtBriefing_toViewData {};

    //
    class missionsMgr_txtFailure_onLoad {};

    //
    class missionsMgr_txtFailure_onRefresh {};

    //
    class missionsMgr_txtFailure_toViewData {};

    //
    class missionsMgr_txtSuccess_onLoad {};

    //
    class missionsMgr_txtSuccess_onRefresh {};

    //
    class missionsMgr_txtSuccess_toViewData {};
};
