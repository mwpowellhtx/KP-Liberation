
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

    // HUD overlay 'onUnload' event handler
    class hud_onUnload {};

    // Responds when a STATUS REPORT occurs, or BLANK the overlay HUD
    class hud_onStatusReport {};
};
