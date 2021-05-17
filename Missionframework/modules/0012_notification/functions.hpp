/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 10:56:52
    Last Update: 2021-05-17 12:14:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

// class notwhatever syntax highlighting strangeness
// TODO: TBD: see: syntax highlighting... https://github.com/Armitxes/VSCode_SQF/issues/55
class notification {
    file = "modules\0012_notification\fnc";

    // Initialization phase event handler
    class notification_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class notification_onPostInit {
        postInit = 1;
    };

    // Offers a hint to the player for a few moments
    class notification_hint {};

    // Shows a notification using the BIS function
    class notification_show {};
};
