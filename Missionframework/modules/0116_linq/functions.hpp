/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:37:45
    Last Update: 2021-06-14 16:35:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class linq {
    file = "modules\0116_linq\fnc";

    // Initialization phase event handler
    class linq_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class linq_onPostInit {
        postInit = 1;
    };

    // Returns whether ALL of the elements match the PREDICATE
    class linq_all {};

    // Returns whether ANY of the elements match the PREDICATE
    class linq_any {};

    // Returns just the target HASHMAP values themselves
    class linq_getHashMapValues {};

    // Rolls the SIDES TIMES numbers of times optionally SUM
    class linq_roll {};

    // Performs a die roll on par with that of HERO GAMES Body Damage
    class linq_heroSystemBodyRoll {};

    // Identifies the minimum element from a given array
    class linq_min {};

    // Identifies the maximum element from a given array
    class linq_max {};

    // Provides a LINQ style zip function
    class linq_first {};

    // Provides a LINQ style zip function
    class linq_last {};

    // Provides a LINQ style select function
    class linq_select {};

    // Provides a LINQ style selectMany function
    class linq_selectMany {};

    // Provides a LINQ style zip function
    class linq_zip {};

    // Provides a LINQ style aggregate function
    class linq_aggregate {};

    // Provides a LINQ style sum function
    class linq_sum {};

    // Provides a LINQ style reverse function
    class linq_reverse {};

    // Verifies that the tuple shape equals that of a given template
    class linq_tupleShapeEquals {};

    // Verifies that the value is between the lower and upper bound, given an optional predicate
    class linq_between {};
};
