/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 22:11:43
    Last Update: 2021-03-05 22:11:46
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

    // Sets a bundle of variables for the provided CBA namespace
    class namespace_setVars {};

    // Gets a bundle of variables from the provided CBA namespace
    class namespace_getVars {};

    // Returns a created CBA namespace
    class namespace_create {};

    // Does routine GC on the CBA namespace
    class namespace_onGC {};
};