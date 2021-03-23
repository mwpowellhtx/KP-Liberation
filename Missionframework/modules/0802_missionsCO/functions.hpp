/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2021-03-19 17:42:23
    Last Update: 2021-03-22 10:11:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines for all functions, which are brought by this module.
 */

class missionsCO {
    file = "modules\0802_missionsCO\fnc";

    // Module initialization phase event handler
    class missionsCO_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class missionsCO_onPostInit {
        postInit = 1;
    };

    //
    class missionsCO_debug {};

    // Responds to client 'onRequest' server events
    class missionsCO_onRequest {};

    // Responds to client 'onRequest::run' server events
    class missionsCO_onRequestRun {};

    // Responds to client 'onRequest::abort' server events
    class missionsCO_onRequestAbort {};
};
