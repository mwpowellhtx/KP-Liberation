/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:20:59
    Last Update: 2021-03-22 10:12:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class missions {
    file = "modules\0800_missions\fnc";

    // Module initialization phase event handler
    class missions_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missions_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should do some debugging
    class missions_debug {};

    // CBA Settings initialization for this module
    class missions_settings {};

    // Performs routine GARBAGE COLLECTION on the TARGET MISSION
    class missions_onGC {};

    // Creates a CBA MISSION TEMPLATE namespace
    class missions_createTemplate {};

    // Clones the given CBA MISSION as a new namespace; typically based on a TEMPLATE
    class missions_cloneMission {};

    // Registers ONE MISSION TEMPLATE
    class missions_registerOne {};

    // Registers zero or more MISSION TEMPLATES
    class missions_registerMany {};

    // Returns the configured REBATE VALUE
    class missions_getRebateValue {};

    // Returns the MISSIONS LISTS, first one are MISSION TEMPLATES, second are the RUNNING MISSIONS
    class missions_onGetLists {};

    // Returns the MISSION corresponding to the 'uuid' and 'templateUuid'
    class missions_getMissionByUuid {};

    // Returns a human readable status report based on the MISSION STATUS bit flags
    class missions_getStatusReport {};

    // Checks the STATUS of either the raw target, or variable in the CBA MISSION namespace
    class missions_checkStatus {};

    // Sets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class missions_setStatus {};

    // Unsets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class missions_unsetStatus {};

    // Returns whether the raw or CBA MISSION namespace hosted TIMER has elapsed
    class missions_timerHasElapsed {};

    // Module mission data serialization event handler
    class missions_onLoadData {};

    // Module mission data serialization event handler
    class missions_onSaveData {};

    // // Registers one single mission namespace with the parent state machine object
    // class missions_registerOne {};

    // // Registers zero or more mission namespaces with the parent state machine object
    // class missions_registerMany {};

// TODO: TBD: next, bits to verify shape of namespace, tuple
// TODO: TBD: and to convert between the shapes, if at all possible...
// TODO: TBD: or at least with enough detail to convert namespace to tuple, for UI presentation...

    //
    class missions_onNoOp {};

    // Returns a default set of TELEMETRY, or as specified by the CBA MISSION namespace
    class missions_onNoTelemetry {};

    // Returns the TELEMETRY corresponding to the TUPLE ARRAY form factor
    class missions_getArrayTelemetry {};

    // Transforms the CBA MISSION namespace to TUPLE ARRAY form factor useful for missions manager clients
    class missions_namespaceToArray {};
};
