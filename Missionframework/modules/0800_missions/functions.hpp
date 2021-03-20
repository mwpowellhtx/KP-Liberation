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

class mission {
    file = "modules\0800_missions\fnc";

    // Module initialization phase event handler
    class missions_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missions_onPostInit {
        postInit = 1;
    };

    // CBA Settings initialization for this module
    class missions_settings {};

    // Creates a CBA MISSION TEMPLATE namespace
    class missions_createTemplate {};

    // Clones the given CBA MISSION as a new namespace; typically based on a TEMPLATE
    class missions_cloneMission {};

    // Returns the configured REBATE VALUE
    class missions_getRebateValue {};

    // Returns a human readable status report based on the MISSION STATUS bit flags
    class missions_getStatusReport {};

    // Module mission data serialization event handler
    class missions_onLoadData {};

    // Module mission data serialization event handler
    class missions_onSaveData {};

    // // Registers one single mission namespace with the parent state machine object
    // class missions_registerOne {};

    // // Registers zero or more mission namespaces with the parent state machine object
    // class missions_registerMany {};

    //
    class missions_onNoOp {};
};
