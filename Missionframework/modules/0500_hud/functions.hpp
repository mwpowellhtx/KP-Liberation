
// ...

class hud {
    file = "modules\0500_hud\fnc";

    // Module initialization phase event handler
    class hud_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class hud_onPostInit {
        postInit = 1;
    };

    // Gets whether the caller should debug
    class hud_debug {};

    // Prepares the module settings
    class hud_settings {};

    // Setup player actions
    class hud_setupPlayerActions {};

    // Checks the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_checkPlayerStatus {};

    // Conditionally sets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_setPlayerStatus {};

    // Conditionally unsets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_unsetPlayerStatus {};

    // Returns whether the elements are in range of each other; favors FOB elements by default
    class hud_inRange {};

    // Returns whether the SECTOR elements are in range of each other; designed specifically for SECTOR concerns
    class hud_sectorInRange {};

    // Refreshes the specified PLAYER TIMER; prefers DISPATCH, but may specify either
    class hud_onRefreshPlayerTimer {};

    // Returns whether the PLAYER TIMER has elapsed; prefers DISPATCH, but may specify either
    class hud_hasPlayerTimerElapsed {};

    // HUD overlay 'onLoad' event handler
    class hud_onLoad {};

    // FOB CT_LISTNBOX 'onLoad' event handler
    class hud_lnbFob_onLoad {};

    // FOB CT_CONTROLS_TABLE 'onLoad' event handler
    class hud_ctFob_onLoad {};

    // FOB CT_CONTROLS_TABLE control 'onLoad' event handler
    class hud_ctFob_ctrl_onLoad {};

    // // HUD overlay 'onUnload' event handler
    // class hud_onUnload {};

    // Responds when a STATUS REPORT occurs, or BLANK the overlay HUD
    class hud_onStatusReport {};

    // // Reports SECTOR elements to the HUD overlay
    // class hud_onReportSector {};

    // // Reports FOB elements to the HUD overlay
    // class hud_onReportFob {};

    // grpBase CT_CONTROLS_GROUP onLoad event handler
    class hud_grpBase_onLoad {};

    // Base CTRL onLoad event handler
    class hud_ctrlBase_onLoad {};

    // General use lblMarkerText CT_STATIC onLoad event handler
    class hud_lblMarkerText_onLoad {};

    // // grpSector CT_CONTROLS_GROUP onLoad event handler
    // class hud_grpSector_onLoad {};

    // // grpSector::lblMarkerText CT_STATIC onLoad event handler
    // class hud_grpSector_lblMarkerText_onLoad {};

    // // grpFob CT_CONTROLS_GROUP onLoad event handler
    // class hud_grpFob_onLoad {};

    // // grpFob::lblMarkerText CT_STATIC onLoad event handler
    // class hud_grpFob_lblMarkerText_onLoad {};

    // PLAYER centric HUD oriented set of CTRL value; may render anything, prefers STRING
    class hud_ctrlSetText {};

    // PLAYER centric change to a DISPLAY or CTRL 'when' a condition has been satisfied
    class hud_ctrlChangeWhen {};
};
