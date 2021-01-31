/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:16
    Last Update: 2021-01-28 02:38:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class uuid {
    file = "modules\xx_uuid\fnc";

    // Creates a UUID array
    class uuid_create {};

    // Creates a UUID string
    class uuid_create_string {};

    // Verifies whether an array can be considered a valid UUID
    class uuid_verify {};

    // Verifies whether a string can be considered a valid UUID
    class uuid_verify_string {};

    // Initialize UUID module
    class uuid_preInit {
        preInit = 1;
    };

    // Initialize UUID module
    class uuid_postInit {
        postInit = 1;
    };
};
