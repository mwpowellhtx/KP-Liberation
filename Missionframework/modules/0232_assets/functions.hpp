/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:02:47
    Last Update: 2021-05-25 23:02:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class assets {
    file = "modules\0232_assets\fnc";

    // Arranges for module preset variables
    class assets_presets {};

    // Arranges for module CBA settings
    class assets_settings {};

    // Initialization phase event handler
    class assets_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class assets_onPostInit {
        postInit = 1;
    };

    // Returns the TALLY of ASSETS matching the FILTER
    class assets_getAssetTally {};

    // Returns the MOBILE ASSETS corresponding to the player side
    class assets_getMobileAssets {};

    // Returns the STATIC ASSETS corresponding to the player side
    class assets_getStaticAssets {};

    // Returns whether the ASSET shall be counted
    class assets_shouldBeCounted {};
};
