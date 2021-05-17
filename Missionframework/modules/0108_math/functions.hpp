/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:56
    Last Update: 2021-05-17 12:19:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class math {
    file = "modules\0108_math\fnc";

    // Converts from a decimal value to base radix
    class math_convertDecimalToBaseRadix {};

    // Initialization phase event handler
    class math_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class math_onPostInit {
        postInit = 1;
    };
};
