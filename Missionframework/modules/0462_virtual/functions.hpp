/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-18
    Last Update: 2021-06-14 17:07:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class virtual {
    file = "modules\0462_virtual\fnc";

    // Adds curator to player
    class virtual_addCurator {};

    // Limit curator editing area
    class virtual_curatorAreaLimit {};

    // Remove curator FOB indicators
    class virtual_curatorRemoveFobIcons {};

    // Update curator FOB indicators
    class virtual_curatorUpdateFobIcons {};

    // Initializes curator handling for player
    class virtual_initCuratorOnPlayer {};

    // Arranges the player actions
    class virtual_setupPlayerActions {};

    // Initialization phase event handler
    class virtual_postInit {
        postInit = 1;
    };

    // Initialization phase event handler
    class virtual_preInit {
        preInit = 1;
    };

    // Remove curator to player
    class virtual_removeCurator {};

    // Setup settings for this module
    class virtual_settings {};
};
