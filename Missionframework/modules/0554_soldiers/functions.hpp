/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:41:53
    Last Update: 2021-06-14 17:16:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class soldiers {
    file = "modules\0554_soldiers\fnc";

    // Initialization phase event handler
    class soldiers_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class soldiers_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class soldiers_settings {};

    // Returns the units that are near the POSITION
    class soldiers_getNear {};

    // Returns whether there are units near the POSITION
    class soldiers_checkNear {};

    // Returns whether a UNIT may ACTIVATE a SECTOR
    class soldiers_canActivateSector {};
};
