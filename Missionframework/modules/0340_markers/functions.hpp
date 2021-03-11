/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-10-18
    Last Update: 2019-05-04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class markers {
    file = "modules\0340_markers\fnc";

    // Module post initialization
    class markers_onPostInit {
        postInit = 1;
    };

    // Module pre initialization
    class markers_onPreInit {
        preInit = 1;
    };

    // Creates a map marker given nominal arguments
    class markers_create {};

    // Deletes a map marker given nominal arguments
    class markers_delete {};
};
