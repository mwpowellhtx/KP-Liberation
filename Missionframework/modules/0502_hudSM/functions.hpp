
class hudSM {
    file = "modules\0502_hudSM\fnc";

    // Module initialization phase event handler
    class hudSM_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class hudSM_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should perform debugging
    class hudSM_debug {};

    // Configures the module settings
    class hudSM_settings {};

    // Creates the client side HUD state machine and initializes
    class hudSM_createSM {};

    // Returns with the client side 'player list' of sorts initialized and ready
    class hudSM_onGetList {};

    // Performs a no-op for use when tracing and troubleshooting the HUD statemachine
    class hudSM_onNoOp {};
};
