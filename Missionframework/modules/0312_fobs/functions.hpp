/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:03:29
    Last Update: 2021-05-17 20:03:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

// Eden is code for Operations Base
class eden {
    file = "modules\0312_fobs\fnc";

    // Arranges module settings
    class fobs_settings {};

    // UPDATE MARKERS event handler
    class fobs_onUpdateMarkers {};

    // Initialization phase event handler
    class fobs_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class fobs_onPostInit {
        postInit = 1;
    };
};
