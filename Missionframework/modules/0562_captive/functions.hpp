/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-10
    Last Update: 2021-06-14 17:20:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines for all functions, which are brought by this module.
 */

// TODO: TBD: we can kind of see why events were connected here how they were...
// TODO: TBD: but when there is some confusion between captor and captee, for instance, or escort and captive...
// TODO: TBD: may reconsider which object(s) are receiving the actions, whether to install/uninstall them, and so forth...
class captive {
    file = "modules\0562_captive\fnc";

    // Adds all needed actions to a surrendered unit
    class captive_addCaptiveActions {};

    // // Checks the given sector for remaining enemys and sets them into captive mode
    // class captive_checkSector {};

    // Attach a captive to the escorting player
    class captive_escort {};

    // Interrogates the unit, adds intel and deletes it
    class captive_interrogate {};

    // Loads given unit into the nearest vehicle cargo seat
    class captive_loadCaptive {};

    // Module post initialization
    class captive_postInit {
        postInit = 1;
    };

    // Module pre initialization
    class captive_preInit {
        preInit = 1;
    };

    // Checks for ACE handcuffed units and rebinds them into the Liberation captive system
    class captive_setAceCaptive {};

    // Sets an unit into captive mode
    class captive_setCaptive {};

    // Given unit surrenders
    class captive_setSurrender {};

    // CBA Settings for this module
    class captive_settings {};

    // Detach a captive from the escorting player
    class captive_stopEscort {};

    // Unloads the give unit and removes the action from the vehicle
    class captive_unloadCaptive {};

    // Surrenders a VEHICLE disembarks the crew and prohibits them from reloading
    class captive_setVehicleSurrender {};

    // // TODO: TBD: we may run with this, but it is pasta on the wall at the moment, seeing what might stick or not...
    //
    //class captive_onSurrenderGC {};

    //
    class captive_onCaptiveGC {};

    //
    class captive_onWatchCaptives {};
};
