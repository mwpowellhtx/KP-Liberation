/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-27 14:27:05
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

class hud {
    file = "modules\0436_hud\fnc";

    // Prepares the module preset variables
    class hud_presets {};

    // Prepares the module CBA settings
    class hud_settings {};

    // Module initialization phase event handler
    class hud_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class hud_onPostInit {
        postInit = 1;
    };

    // Returns the HUD report object
    class hud_getReport {};

    // Handles the internal HUD REPORT scaffold during regular WAE periods
    class hud_onReport {};

    // Returns whether the REPORT is ALIGNED with an EXPECTED UUID
    class hud_aligned {};

    // Subscribes to a HUD REPORT and hands off a WUAE+WAE event baton
    class hud_subscribe {};
};

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
