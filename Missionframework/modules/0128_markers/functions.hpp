/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 12:31:32
    Last Update: 2021-05-17 12:31:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class markers {
    file = "modules\0128_markers\fnc";

    // Initialization phase event handler
    class markers_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class markers_onPostInit {
        postInit = 1;
    };

    // Creates a map marker given nominal arguments
    class markers_create {};

    // Deletes a map marker given nominal arguments
    class markers_delete {};
};
