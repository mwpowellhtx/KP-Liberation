/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:42
    Last Update: 2021-05-17 12:29:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class timers {
    file = "modules\0124_timers\fnc";

    // Formats the systemTime with appropriate padding
    class time_formatSystemTime {};

    // Initialization phase event handler
    class timers_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class timers_onPostInit {
        postInit = 1;
    };

    // Returns the current time, defaults to returning 'serverTime'
    class timers_now {};

    // Returns a newly minted timer tuple
    class timers_create {};

    // Refreshes the timer with respect to _now or ([] call KPLIB_fnc_timers_now)
    class timers_refresh {};

    // Rebases the timer with respect to ([] call KPLIB_fnc_timers_now)
    class timers_rebase {};

    // Inverts the timer swapping elapsed time with time remaining then rebasing to recalibrate
    class timers_invert {};

    // Fast forwards the given timer instance by a _delta time in seconds
    class timers_fastForward {};

    // Slides the timer instance forward relative to ([] call KPLIB_fnc_timers_now)
    class timers_slideForward {};

    // Verifies that the timer instnace is valid
    class timers_verify {};

    // Returns whether the timer can be considered to be running
    class timers_isRunning {};

    // Returns whether the timer is approaching the moment of having elapsed
    class timers_isApproaching {};

    // Returns whether the timer instance has elapsed
    class timers_hasElapsed {};

    // Returns whether the timer instance has tripped
    class timers_hasTripped {};

    // Returns the rendered timer component to string format, "#.##:##:##"
    class timers_renderComponentString {};
};
