
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

    // Checks the PLAYER HUD STATUS
    class hud_checkPlayerStatus {};

    // Conditionally sets a HUD mask the PLAYER HUD STATUS
    class hud_setPlayerStatus {};

    // Conditionally unsets a HUD mask the PLAYER HUD STATUS
    class hud_unsetPlayerStatus {};

    // SITREP overlay 'onLoad' event handler
    class hud_onSitrepLoad {};

    // SITREP overlay 'onUnload' event handler
    class hud_onSitrepUnload {};
};
