/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:53:04
    Last Update: 2021-02-20 16:53:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.

    Dependencies:
        0410_production
*/

class productionsm {
    file = "modules\0412_productionsm\fnc";

    // Module pre initialization
    class productionsm_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionsm_onPostInit {
        postInit = 1;
    };

    //
    class productionsm_debug {};

    //
    class productionsm_createSM {};

    //
    class productionsm_getNamespace {};

    //
    class productionsm_assessCapabilityDebit {};

    //
    class productionsm_enqueueChangeOrder {};

    //
    class productionsm_dequeueChangeOrder {};

    //
    class productionsm_hasChangeOrders {};

    //
    class productionsm_getAddCapabilityNotificationKey {};

    //
    class productionsm_getCapabilityCost {};

    //
    class productionsm_onAddCapabilityRaised {};

    //
    class productionsm_hasPublicationTimer {};

    //
    class productionsm_hasProductionTimerElapsed {};

    //
    class productionsm_onChangeQueueRaised {};

    //
    class productionsm_onNextChangeOrder {};

    //
    class productionsm_hasQueueRemaining {};

    //
    class productionsm_onPublishRequestTransition {};

    //
    class productionsm_onProducerEntered {};

    //
    class productionsm_onProducerLeaving {};

    //
    class productionsm_isRunning {};

    //
    class productionsm_isSecure {};

    //
    class productionsm_onProductionMgrOpened {};

    //
    class productionsm_onProductionMgrClosed {};

    //
    class productionsm_onPublisher {};

    //
    class productionsm_onPublisherEntered {};

    //
    class productionsm_onPublisherLeaving {};

    //
    class productionsm_onRebaseEntered {};

    //
    class productionsm_onScheduler {};

    //
    class productionsm_raiseAddCapability {};

    //
    class productionsm_raiseChangeQueue {};

    //
    class productionsm_tryProduceResource {};

    //
    class productionsm_hasManagers {};

    //
    class productionsm_onPublicationTimerRefresh {};

    //
    class productionsm_onForcedPublication {};
};
