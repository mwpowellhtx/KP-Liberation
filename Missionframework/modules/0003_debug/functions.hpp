/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:39:17
    Last Update: 2021-02-04 13:39:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class debug {
    file = "modules\0003_debug\fnc";

    // Initialize debug module
    class debug_onPreInit {
        preInit = 1;
    };

    // Initialize debug module
    class debug_onPostInit {
        postInit = 1;
    };

    // Advises whether the caller should conduct debugging
    class debug_debug {};
};
