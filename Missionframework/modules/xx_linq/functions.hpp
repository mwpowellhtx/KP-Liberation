/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:37:45
    Last Update: 2021-01-28 02:37:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class linq {
    file = "modules\xx_linq\fnc";

    // Identifies the minimum element from a given array
    class linq_min {};

    // Provides a LINQ style zip function
    class linq_first {};

    // Provides a LINQ style zip function
    class linq_last {};

    // Provides a LINQ style zip function
    class linq_zip {};

    // Provides a LINQ style aggregate function
    class linq_aggregate {};

    // Initialize linq module
    class linq_preInit {
        preInit = 1;
    };

    // Initialize linq module
    class linq_postInit {
        postInit = 1;
    };
};
