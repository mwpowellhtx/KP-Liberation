/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:41:53
    Last Update: 2021-04-06 11:41:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class _units {
    file = "modules\0155_units\fnc";

    // Initialization phase event handler
    class units_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class units_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class units_settings {};

    // Returns the units that are near the POSITION
    class units_getNear {};

    // Returns whether there are units near the POSITION
    class units_checkNear {};
};
