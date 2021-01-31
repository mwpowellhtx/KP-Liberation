/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 13:28:16
    Last Update: 2021-01-28 13:28:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class config {
    file = "modules\xx_config\fnc";

    // Returns the preset settings informing a CBA combo box
    class config_getPresetSettingValue {};

    // Registers the setting with the CBA settings module
    class config_onRegisterSetting {};

    // Registers several sets (ARRAY) of settings with the CBA settings module
    class config_onRegisterSettings {};

    // Initializes some preset settings
    class config_presets {};

    // Initializes the CBA settings
    class config_settings {};

    // Module pre initialization
    class config_preInit {
        preInit = 1;
    };

    // Module post initialization
    class config_postInit {
        postInit = 1;
    };
};
