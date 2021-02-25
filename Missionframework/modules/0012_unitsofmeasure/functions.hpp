/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 08:17:25
    Last Update: 2021-02-25 08:17:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class unitsofmeasure {
    file = "modules\0012_unitsofmeasure\fnc";

    // Pre-initialization phase module event handler
    class uom_onPreInit {
        preInit = 1;
    };

    // Post-initialization phase module event handler
    class uom_onPostInit {
        postInit = 1;
    };
};
