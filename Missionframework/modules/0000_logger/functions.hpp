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

class logger {
    file = "modules\0000_logger\fnc";

    // TODO: TBD: leaving this named common_log for now... else we would need to touch literally EVERY EFFING THING...
    // TODO: TBD: that is quite a bit more than we want to do for an initial spring...
    // Logs given text to server rpt
    class common_log {};

    // Initialize time module
    class logger_preInit {
        preInit = 1;
    };

    // Initialize time module
    class logger_postInit {
        postInit = 1;
    };
};
