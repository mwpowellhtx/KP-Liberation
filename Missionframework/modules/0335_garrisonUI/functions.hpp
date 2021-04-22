/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:04:11
    Last Update: 2021-04-16 14:04:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class garrisonUI {
    file = "modules\0335_garrisonUI\fnc";

    // Initialization phase event handler
    class garrisonUI_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class garrisonUI_onPostInit {
        postInit = 1;
    };

    // Prepares the module settings
    class garrisonUI_settings {};

    //
    class garrisonUI_setupPermissions {};

    //
    class garrisonUI_setupPlayerActions {};

    // Handle button click for unit/group adding
    class garrisonUI_dialogAdd {};

    // Handle button click of infantry/vehicle removal
    class garrisonUI_dialogRemove {};

    // Handle group selection in garrison dialog
    class garrisonUI_dialogSelectGroup {};

    // Handle new selection in garrison dialog
    class garrisonUI_dialogSelectSector {};

    // Handle unit selection in garrison dialog
    class garrisonUI_dialogSelectUnit {};

    // Opens the garrison dialog
    class garrisonUI_openDialog {};
};
