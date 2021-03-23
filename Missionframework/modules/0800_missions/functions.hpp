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

    // Module mission data serialization event handler
    class missions_onLoadData {};

    // Module mission data serialization event handler
    class missions_onSaveData {};

    // Returns a human readable status report based on the MISSION STATUS bit flags
    class mission_getStatusReport {};

    // Sets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class mission_setStatus {};

    // Unsets the conditional bitwise STATUS itself, or that of its host CBA MISSION namespace
    class mission_unsetStatus {};

    // Checks the STATUS of either the raw target, or variable in the CBA MISSION namespace
    class mission_checkStatus {};

    // Returns whether the raw or CBA MISSION namespace hosted TIMER has elapsed
    class mission_timerHasElapsed {};

    // A no-op placeholder callback used throughout the state machine and missions framework.
    class mission_onNoOp {};

    // No-op default setup callback, returns KPLIB_mission_status_started
    class mission_onNoOpSetup {};

    // No-op default mission callback, returns KPLIB_mission_status_standby
    class mission_onNoOpMission {};

    // No-op default tear down callback, returns KPLIB_mission_status_completed
    class mission_onNoOpTearDown {};

    // Returns a default set of TELEMETRY, or as specified by the CBA MISSION namespace
    class mission_onNoOpTelemetry {};

    // Returns the TELEMETRY corresponding to the TUPLE ARRAY form factor
    class mission_getArrayTelemetry {};

    // Transforms the CBA MISSION namespace to TUPLE ARRAY form factor useful for missions manager clients
    class mission_namespaceToArray {};

    // Performs routine GARBAGE COLLECTION on the TARGET MISSION
    class mission_onGC {};
};
