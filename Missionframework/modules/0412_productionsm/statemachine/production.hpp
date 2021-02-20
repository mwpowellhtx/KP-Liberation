
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

class KPLIB_productionStatemachine {
    list = 'KPLIB_production_namespaces';
    skipNull = 1;

    /* The KPLIB production statemachine enters this mode once and only once in order to recalibrate
     * the known running production timers according to the current mission 'serverTime'.
     *
     * References:
     *      https://community.bistudio.com/wiki/serverTime
     */
    class Rebaser {
        onStateEntering = '_this call KPLIB_fnc_productionsm_onRebaseEntering;';

        // Always publish
        class OnSemperPublish {
            targetState = "Publisher";
            condition = 'true;';
        };
    };

    // // TODO: TBD: ensure that we are saving at opportune strategic moments...
    // [] call KPLIB_fnc_init_save;

    // // // TODO: TBD: also, specifically, when we have something to update on map...
    // // And re-render the production sector marker text
    // _namespace call KPLIB_fnc_production_onRenderMarkerText;

    // Publish the namespace to qualified listeners on the next cycle...
    class Publisher {
        onStateEntering = '_this call KPLIB_fnc_productionsm_onPublisherEntering;';
        onState = '_this call KPLIB_fnc_productionsm_onPublisher;';
        onStateLeaving = '_this call KPLIB_fnc_productionsm_onPublisherLeaving;';

        class On0SemperScheduler : OnSemperPublish {
            targetState = "Scheduler";
        };
    };

    /* We camp here scheduling or rescheduling a factory sector production timer, until such
     * time as the production '_timer' has elapsed, or a change order has arrived requiring
     * statemachine attention. The '_timer' is scheduled as a function of factory sector
     * control and of '_queue' state having changed in some way, shape, or form. */
    class Scheduler {
        onState = '_this call KPLIB_fnc_productionsm_onScheduler;';

        class OnPublish {
            targetState = "Publisher";
            condition = '
                !(
                    (_this call KPLIB_fnc_productionsm_hasElapsed)
                        || (_this call KPLIB_fnc_productionsm_hasChangeOrders)
                );
            ';
        };

        // Publish when, i.e. a productionMgr dialog announces himself to the server
        class OnPublishRequested : OnPublish {
            events[] = {
                "KPLIB_productionsm_onPublishProductionElem"
            };
            condition = 'true;';
        };

        // Process change orders on event...
        class OnEdictMutatioRaised {
            events[] = {
                "KPLIB_productionsm_onChangeOrder"
            };
            targetState = "EdictMutatio";
            condition = '
                (_this call KPLIB_fnc_productionsm_hasChangeOrders);
            ';
        };

        class OnProduction {
            targetState = "Producer";
            condition = '
                (_this call KPLIB_fnc_productionsm_hasElapsed)
                    && !(_this call KPLIB_fnc_productionsm_hasChangeOrders);
            ';
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
    class Producer {
        onStateEntering = '_this call KPLIB_fnc_productionsm_onProducerEntering;';
        onState = '_this call KPLIB_fnc_productionsm_onProducer;';

        // TODO: TBD: CO conditions probably unnecessary, or we consider an event transition...
        class OnCondicionalisEdictMutatio : OnSemperPublish {
            targetState = "EdictMutatio";
            condition = '_this call KPLIB_fnc_productionsm_hasChangeOrders;';
        };

        class OnCondicionalisPublish : OnSemperPublish {
            condition = '!(_this call KPLIB_fnc_productionsm_hasChangeOrders);';
        };
    };

    // Process the change orders while we have some...
    class EdictMutatio {
        onState = '_this call KPLIB_fnc_productionsm_onNextChangeOrder;';

        // Notify production manager listeners ASAP when able to do so...
        class OnCondicionalisPublish : OnSemperPublish {
            condition = '!(_this call KPLIB_fnc_productionsm_hasChangeOrders);';
        };
    };
};
