/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 14:59:54
    Last Update: 2021-05-17 15:46:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class wounded {
    file = "modules\0912_wounded\fnc";

    // Module initialization phase event handler
    class wounded_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class wounded_onPostInit {
        postInit = 1;
    };

    // Module settings initialization
    class wounded_settings {};

    // SECTOR CAPTURED event handler
    class wounded_onSectorCaptured {};
};
