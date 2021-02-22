
// https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_addState-sqf.html
// https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_addTransition-sqf.html
// https://github.com/CBATeam/CBA_A3/blob/master/addons/statemachine/example.hpp

/*
 * States:
 *  - refreshtimer
 *  - producecrate
 *  -
 *  -
 *  -
 *  -
 *  -
 *
 * Transitions:
 *  - ontimerelapsed
 *  - ontimernotelapsed
 *  - oncontainerfull
 *  -
 *  -
 *  -
 *  -
 *  -
 *  -
 *
 * Conditions:
 *  - sector secure
 *  - has queue remaining
 *  - can be scheduled (queue changed)
 *  - timer is running
 *  - timer has elapsed
 *  - 
 *  - 
 *
 *
 *
 *
 *
 */

class KPLIB_productionsm_statemachine {
    list = "KPLIB_production_namespaces";
    skipNull = 1;

    /* The KPLIB production statemachine enters this mode once and only once in order to recalibrate
     * the known running production timers according to the current mission 'serverTime'.
     *
     * References:
     *      https://community.bistudio.com/wiki/serverTime
     */
    class KPLIB_productionsm_state_rebaser {
        onStateEntered = "[_this] call KPLIB_fnc_productionsm_onRebaseEntered;";

        // Always publish
        class KPLIB_productionsm_transition_onSemperPublish {
            targetState = "KPLIB_productionsm_state_publisher";
            condition = "true";
        };
    };

    // // TODO: TBD: ensure that we are saving at opportune strategic moments...
    // [] call KPLIB_fnc_init_save;

    // // // TODO: TBD: also, specifically, when we have something to update on map...
    // // And re-render the production sector marker text
    // _namespace call KPLIB_fnc_production_onRenderMarkerText;

    // Publish the namespace to qualified listeners on the next cycle...
    class KPLIB_productionsm_state_publisher {
        onStateEntered = "[_this] call KPLIB_fnc_productionsm_onPublisherEntered;";
        onState = "[_this] call KPLIB_fnc_productionsm_onPublisher;";
        onStateLeaving = "[_this] call KPLIB_fnc_productionsm_onPublisherLeaving;";

        class KPLIB_productionsm_transition_onCondicionalisEdictMutatio {
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "([_this] call KPLIB_fnc_productionsm_hasChangeOrders);";
        };

        class KPLIB_productionsm_transition_onEdictMutatioRaised {
            events[] = {
                "KPLIB_productionsm_onChangeOrder"
            };
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "true";
        };

        class KPLIB_productionsm_transition_onSemperScheduler {
            targetState = "KPLIB_productionsm_state_scheduler";
            condition = " \
                ([KPLIB_fnc_timers_isRunning] call KPLIB_fnc_productionsm_hasPublicationTimer) \
                    && !([] call KPLIB_fnc_productionsm_hasPublicationTimer) \
                    && !([_this] call KPLIB_fnc_productionsm_hasChangeOrders); \
            ";
        };
    };

    /* We camp here scheduling or rescheduling a factory sector production timer, until such
     * time as the production '_timer' has elapsed, or a change order has arrived requiring
     * statemachine attention. The '_timer' is scheduled as a function of factory sector
     * control and of '_queue' state having changed in some way, shape, or form. */
    class KPLIB_productionsm_state_scheduler {
        onStateEntered = "[_this] call KPLIB_fnc_productionsm_onSchedulerEntered;";
        onState = "[_this] call KPLIB_fnc_productionsm_onScheduler;";

        class KPLIB_productionsm_transition_onPublish {
            targetState = "KPLIB_productionsm_state_publisher";
            condition = " \
                ([] call KPLIB_fnc_productionsm_hasManagers) \
                    && ([KPLIB_fnc_timers_isRunning] call KPLIB_fnc_productionsm_hasPublicationTimer) \
                    && ([] call KPLIB_fnc_productionsm_hasPublicationTimer); \
            ";
        };

        // Publish when, i.e. a productionMgr dialog announces himself to the server
        class KPLIB_productionsm_transition_onPublishRequest : KPLIB_productionsm_transition_onPublish {
            events[] = {
                "KPLIB_productionsm_onPublishProductionState"
            };
            condition = "true";
            onTransition = "([_this] call KPLIB_fnc_productionsm_onPublishRequestTransition);";
        };

        class KPLIB_productionsm_transition_onCondicionalisEdictMutatio {
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "([_this] call KPLIB_fnc_productionsm_hasChangeOrders);";
        };

        // Process change orders on event...
        class KPLIB_productionsm_transition_onEdictMutatioRaised {
            events[] = {
                "KPLIB_productionsm_onChangeOrder"
            };
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "true";
        };

        class KPLIB_productionsm_transition_onProduction {
            targetState = "KPLIB_productionsm_state_producer";
            condition = " \
                ([_this] call KPLIB_fnc_productionsm_hasProductionTimerElapsed) \
                    && !([_this] call KPLIB_fnc_productionsm_hasChangeOrders); \
            ";
        };
    };

    // TODO: TBD: events...
    // TODO: TBD:   1. add capability - from time to time players may add cap to a factory sector production
    // TODO: TBD:   2. change queue - this is by far the most common one, the nerve center of dealing with production
    // TODO: TBD:       - either starts, restarts, or cancels production, accordingly...
    // TODO: TBD:   3. sector lost - when a factory sector is lost, is removed from KPLIB_sectors_blufor, has consequences in the namespace

    // TODO: TBD: how else might we relay change orders to each CBA production namespace (?)


    // TODO: TBD: we do not want to get stuck producing when there is no room, let's say...
    // TODO: TBD: allow room for change orders to occur, which may consequently change the outlook...
    class KPLIB_productionsm_state_producer {
        onStateEntered = "([_this] call KPLIB_fnc_productionsm_onProducerEntered);";
        onState = "[_this] call KPLIB_fnc_productionsm_onProducer;";

        class KPLIB_productionsm_transition_onCondicionalisEdictMutatio {
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "([_this] call KPLIB_fnc_productionsm_hasChangeOrders);";
        };

        class KPLIB_productionsm_transition_onEdictMutatioRaised {
            events[] = {
                "KPLIB_productionsm_onChangeOrder"
            };
            targetState = "KPLIB_productionsm_state_edictMutatio";
            condition = "true";
        };

        class KPLIB_productionsm_transition_onCondicionalisPublish {
            targetState = "KPLIB_productionsm_state_publisher";
            condition = "!([_this] call KPLIB_fnc_productionsm_hasChangeOrders);";
        };
    };

    // Process the change orders while we have some...
    class KPLIB_productionsm_state_edictMutatio {
        onState = "([_this] call KPLIB_fnc_productionsm_onNextChangeOrder);";

        // Notify production manager listeners ASAP when able to do so...
        class KPLIB_productionsm_transition_onCondicionalisPublish {
            targetState = "KPLIB_productionsm_state_publisher";
            condition = "!([_this] call KPLIB_fnc_productionsm_hasChangeOrders);";
            onTransition = "([_this] call KPLIB_fnc_productionsm_onForcedPublication);";
        };
    };
};
