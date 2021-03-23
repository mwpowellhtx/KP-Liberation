/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:20:59
    Last Update: 2021-03-19 17:21:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class missionsSM {
    file = "modules\0801_missionsSM\fnc";

    // Module initialization phase event handler
    class missionsSM_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsSM_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should perform debugging
    class missionsSM_debug {};

    // CBA Settings initialization for this module
    class missionsSM_settings {};

    // Creates a CBA missions state machine
    class missionsSM_createSM {};

    //
    class missionsSM_onGetList {};

    //
    class missionsSM_onNoOp {};

    //
    class missionsSM_onMissionsMgrOpened {};

    //
    class missionsSM_onMissionsMgrClosed {};

    //
    class missionsSM_onBroadcast {};

    //
    class missionsSM_onPublish {};
};
