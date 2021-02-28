/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:55:07
    Last Update: 2021-02-25 13:20:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logisticsSM {
    file = "modules\0445_logisticsSM\fnc";

    // Returns whether caller should conduct debugging
    class logisticsSM_debug {};

    // Module post initialization phase event handler
    class logisticsSM_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsSM_onPreInit {
        preInit = 1;
    };

    // Initializes the CBA settings
    class logisticsSM_settings {};

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrOpened' CBA server event handler
    class logisticsSM_onLogisticsMgrOpened {};

    // Logistics SM 'KPLIB_logistics_onLogisticsMgrClosed' CBA server event handler
    class logisticsSM_onLogisticsMgrClosed {};
};
