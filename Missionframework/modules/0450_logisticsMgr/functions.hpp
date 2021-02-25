/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:55:07
    Last Update: 2021-02-25 13:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logisticsMgr {
    file = "modules\0450_logisticsMgr\fnc";

    // Returns whether caller should conduct debugging
    class logisticsMgr_debug {};

    // Module post initialization phase event handler
    class logisticsMgr_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsMgr_onPreInit {
        preInit = 1;
    };

    // Initializes module CBA settings
    class logisticsMgr_settings {};
};
