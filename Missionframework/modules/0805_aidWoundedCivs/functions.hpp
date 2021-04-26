/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 14:59:54
    Last Update: 2021-04-26 14:59:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class aidWoundedCivs {
    file = "modules\0805_aidWoundedCivs\fnc";

    // Module initialization phase event handler
    class aidWoundedCivs_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class aidWoundedCivs_onPostInit {
        postInit = 1;
    };

    // Module settings initialization
    class aidWoundedCivs_settings {};

    // SECTOR CAPTURED event handler
    class aidWoundedCivs_onSectorCaptured {};
};
