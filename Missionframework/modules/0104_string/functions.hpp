/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-26 07:48:05
    Last Update: 2021-05-17 12:18:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class string {
    file = "modules\0104_string\fnc";

    // Initialization phase event handler
    class string_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class string_onPostInit {
        postInit = 1;
    };

    // Askes whether one string STARTSWITH a substring
    class string_startsWith {};
};
