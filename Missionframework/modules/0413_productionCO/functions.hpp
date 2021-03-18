/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 07:13:01
    Last Update: 2021-03-18 18:30:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class productionCO {
    file = "modules\0413_productionCO\fnc";

    // Module pre initialization
    class productionCO_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionCO_onPostInit {
        postInit = 1;
    };

    // Reports whether the caller should debug
    class productionCO_debug {};

    // Client requests ADD CAPABILITY to a target factory sector
    class productionCO_onRequestAddCap {};

    // Closes the loop on the ADD CAPABILITY client request
    class productionCO_onAddCap {};

    // Evaluates whether the ADD CAPABILITY client request may be performed
    class productionCO_onAddCapEntering {};

    // Makes a capability cost out of the elements
    class productionCO_makeCapDebit {};

    // Tries to debit an added capability and responds with a detailed assessment of the results
    class productionCO_tryDebitCap {};

    // Returns an appropriate CAPABILITY notification string table key
    class productionCO_getCapNotificationKey {};

    // Client requests CHANGE QUEUE for the taget factory sector
    class productionCO_onRequestChangeQueue {};

    // Closes the loop on the CHANGE QUEUE client request
    class productionCO_onChangeQueue {};

    // Evaluates whether the CHANGE QUEUE client request may be performed
    class productionCO_onChangeQueueEntering {};
};
