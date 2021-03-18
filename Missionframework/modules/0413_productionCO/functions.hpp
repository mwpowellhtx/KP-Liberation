/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 07:13:01
    Last Update: 2021-03-17 07:13:04
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

    //// Returns the PRODUCTION CAPABILITY DEBUG assessment
    //class productionCO_getCapabilityDebit {};

    //
    class productionCO_onRequestAddCap {};

    //
    class productionCO_onAddCap {};

    //
    class productionCO_onAddCapEntering {};

    // Makes a capability cost out of the elements
    class productionCO_makeCapDebit {};

    // Tries to debit an added capability and responds with a detailed assessment of the results
    class productionCO_tryDebitCap {};

    //
    class productionCO_getCapNotificationKey {};

    //
    class productionCO_onRequestChangeQueue {};

    //
    class productionCO_onChangeQueue {};

    //
    class productionCO_onChangeQueueEntering {};
};
