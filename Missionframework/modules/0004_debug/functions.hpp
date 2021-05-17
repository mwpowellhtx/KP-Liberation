/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:39:17
    Last Update: 2021-05-17 12:08:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class debug {
    file = "modules\0004_debug\fnc";

    // Initialization phase event handler
    class debug_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class debug_onPostInit {
        postInit = 1;
    };

    // Advises whether the caller should conduct debugging
    class debug_debug {};
};
