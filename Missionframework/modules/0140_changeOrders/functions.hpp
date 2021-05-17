/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 10:31:12
    Last Update: 2021-05-17 15:30:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class changeOrders {
    file = "modules\0140_changeOrders\fnc";

    // Module post initialization phase event handler
    class changeOrders_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class changeOrders_onPreInit {
        preInit = 1;
    };

    // ...
    class changeOrders_debug {};

    // ...
    class changeOrders_create {};

    // ...
    class changeOrders_enqueue {};

    // ...
    class changeOrders_tryDequeue {};

    // ...
    class changeOrders_insert {};

    // ...
    class changeOrders_process {};

    // Processes one single CHANGE ORDER given the TARGET namespace
    class changeOrders_processOne {};

    // Processes zero or more CHANGE ORDERS given the TARGET namespace
    class changeOrders_processMany {};
};
