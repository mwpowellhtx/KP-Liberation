/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:53:04
    Last Update: 2021-03-18 18:27:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.

    Dependencies:
        0410_production
*/

class productionSM {
    file = "modules\0412_productionSM\fnc";

    // Module pre initialization
    class productionSM_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionSM_onPostInit {
        postInit = 1;
    };

    // Indicates to the caller whether to debug
    class productionSM_debug {};

    // Prepares the module settings for use via CBA
    class productionSM_settings {};

    // Creates a PRODUCTION state machine for use throughout the module
    class productionSM_createSM {};

    // Gets the list with every state machine iteration
    class productionSM_onGetList {};

    // Event handler responds when client opens the production manager dialog
    class productionSM_onProductionMgrOpened {};

    // Event handler responsds when client closes the production manager dialog
    class productionSM_onProductionMgrClosed {};

    // No operation placeholder used to debug...
    class productionSM_onNoOp {};

    // CBA PRODUCTION namespace REBASE 'onStateEntered' event handler
    class productionSM_onRebaseEntered {};

    // CBA PRODUCTION namespace PENDING 'onState' event handler
    class productionSM_onStandbyOrPending {};

    // Returns whether the CBA PRODUCTION namespace has a RUNNING TIMER
    class productionSM_hasRunningTimer {};

    // Returns whether the CBA PRODUCTION namespace has an ELAPSED TIMER
    class productionSM_hasElapsedTimer {};

    // CBA PRODUCTION namespace PRODUCTION 'onStateEntered' event handler
    class productionSM_onProductionEntered {};

    // Tries to produce the next resoure in queue
    class productionSM_tryResourceProduction {};

    // CBA PRODUCTION namespace PRODUCTION 'onTransition' event handler
    class productionSM_onStandbyOrPendingTransit {};

    // Gets the LEAD TIME, may return with a PREEMPTIVE LEAD TIME for troubleshooting purposes
    class productionSM_getProductionTimerDuration {};

    // Updates the QUEUE following production one way or another
    class productionSM_onUpdateQueue {};

    // Schedules the next PRODUCTIOM TIMER when there is QUEUE PENDING
    class productionSM_onScheduleTimer {};

    // Broadcasts the current PRODUCTION TUPLES to listening managers
    class productionSM_onBroadcast {};

    // Publishes the current PRODUCTION TUPLES to one listening manager
    class productionSM_onPublish {};

    // Returns whether the BROADCAST TIMER has elapsed; automatically resets the timer when it has elapsed
    class productionSM_hasBroadcastTimerElapsed {};
};
