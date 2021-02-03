/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:42
    Last Update: 2021-01-28 02:38:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class timers {
    file = "modules\0025_timers\fnc";

    // Formats the systemTime with appropriate padding
    class time_formatSystemTime {};

    // Initialize time module
    class timers_preInit {
        preInit = 1;
    };

    // Initialize time module
    class timers_postInit {
        postInit = 1;
    };
};
