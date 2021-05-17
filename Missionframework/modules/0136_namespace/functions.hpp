/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 22:11:43
    Last Update: 2021-05-17 12:56:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class namespace {
    file = "modules\0136_namespace\fnc";

    // Initialization phase event handler
    class namespace_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class namespace_onPostInit {
        postInit = 1;
    };

    // Returns a created CBA namespace
    class namespace_create {};

    // Returns a clone of the CBA namespace, including opportunity to copy a nominal set of variables
    class namespace_clone {};

    // Sets a bundle of variables for the provided CBA namespace
    class namespace_setVars {};

    // Gets a bundle of variables from the provided CBA namespace
    class namespace_getVars {};

    // Checks the bitflags status for the given target
    class namespace_checkStatus {};

    // Conditionally sets the bitflags mask for the given target
    class namespace_setStatus {};

    // Conditionally unsets the bitflags mask for the given target
    class namespace_unsetStatus {};

    // Returns whether the CBA namespace TIMER has elapsed
    class namespace_timerHasElapsed {};

    // Creates a serialization registry HASHMAP for use during serialization
    class namespace_createSerializationRegistry {};

    // Registers or unregisters serialization variables with a HASHMAP registry
    class namespace_registerSerializationVars {};

    // Serializes the CBA NAMESPACE to name value pairs
    class namespace_serialize {};

    // Deserializes the CBA NAMESPACE from name value pairs
    class namespace_deserialize {};

    // Does routine GC on the CBA namespace
    class namespace_onGC {};
};
