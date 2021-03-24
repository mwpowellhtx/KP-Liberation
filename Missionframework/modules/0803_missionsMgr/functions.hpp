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
