/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:20:59
    Last Update: 2021-05-17 15:49:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class firedrill {
    file = "modules\0920_firedrill\fnc";

    // Module initialization phase event handler
    class firedrill_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class firedrill_onPostInit {
        postInit = 1;
    };

    // Returns whether the caller should do some debugging
    class firedrill_debug {};

    // CBA Settings initialization for this module
    class firedrill_settings {};

    //
    class firedrill_onSetup {};

    //
    class firedrill_onMissionEntered {};

    //
    class firedrill_onMission {};

    //
    class firedrill_onTearDown {};

    //
    class firedrill_onCompleteEntered {};

    //
    class firedrill_onUpdate {};

    //
    class firedrill_onGetTelemetry {};
};
