/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 12:48:16
    Last Update: 2021-05-17 12:32:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class triggers {
    file = "modules\0132_triggers\fnc";

    // Arranges for module settings
    class triggers_settings {};

    // Initialization phase event handler
    class triggers_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class triggers_onPostInit {
        postInit = 1;
    };

    // Creates and registers a CBA TRIGGER namespace
    class triggers_create {};

    // Performs routing GC on the TRIGGER object
    class triggers_onGC {};

    // Verifies the ACTIVATION BY component
    class triggers_verifyActivationBy {};

    // Verifies the ACTIVATION TYPE component
    class triggers_verifyActivationType {};

    // Converts a SIDE to an ACTIVATION BY component
    class triggers_sideToBy {};

    // Converts a BOOL value to ACTIVATION PRESENCE TYPE
    class triggers_boolToPresenceType {};

    // Converts a SIDE value to ACTIVATION DETECTION TYPE
    class triggers_sideToDetectionType {};
};
