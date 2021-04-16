/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 22:11:43
    Last Update: 2021-04-16 08:28:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class namespace {
    file = "modules\0105_namespace\fnc";

    // Module post initialization event handler
    class namespace_onPostInit {
        postInit = 1;
    };

    // Module pre initialization event handler
    class namespace_onPreInit {
        preInit = 1;
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

    // Does routine GC on the CBA namespace
    class namespace_onGC {};
};
