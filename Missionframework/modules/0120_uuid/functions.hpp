/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:16
    Last Update: 2021-05-17 12:27:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class uuid {
    file = "modules\0120_uuid\fnc";

    // Creates a UUID array
    class uuid_create {};

    // Creates a UUID string
    class uuid_create_string {};

    // Verifies whether an array can be considered a valid UUID
    class uuid_verify {};

    // Verifies whether a string can be considered a valid UUID
    class uuid_verify_string {};

    // Initialization phase event handler
    class uuid_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class uuid_onPostInit {
        postInit = 1;
    };
};
