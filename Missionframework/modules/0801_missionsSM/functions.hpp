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

    // Returns the array of RUNNING MISSIONS for use with the state machine
    class missionsSM_onGetList {};

    // Default no-op state machine callback, used to help trace through the states and transitions
    class missionsSM_onNoOp {};

    // Callback connects the dots with MISSION MANAGER when opened
    class missionsSM_onMissionsMgrOpened {};

    // Callback disconnects the dots from MISSION MANAGER with closed
    class missionsSM_onMissionsMgrClosed {};

    // Broadcasts the MISSIONS to listening MISSION MANAGER players
    class missionsSM_onBroadcast {};

    // Publishes the MISSIONS to one listening MISSION MANAGER player
    class missionsSM_onPublish {};

    // A default CBA MISSIONS 'onState' or 'onStateEntered' facilitator: 'setup', 'mission', 'tearDown', 'complete'
    class missionsSM_onState {};
};
