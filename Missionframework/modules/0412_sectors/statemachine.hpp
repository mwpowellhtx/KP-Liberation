/*
    File: statemachine.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 14:52:19
    Last Update: 2021-06-14 17:00:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
        https://github.com/CBATeam/CBA_A3/blob/master/addons/statemachine/example.hpp
 */

// TODO: TBD: what to do about certain triggers: i.e.
// TODO: TBD:   - counterattack
// TODO: TBD:   - reinforce
// TODO: TBD:   - anti-air site
// TODO: TBD:   - spawned patrol...

// TODO: TBD: consider end game scenarios, i.e. 'last stand', a function of:
// TODO: TBD:   - 1 metropolis sector remaining?
// TODO: TBD:   - a percentage threshold of city sectors remaining?
// TODO: TBD:   - ditto re: military? factory? tower?
// TODO: TBD:   - i.e. count (KPLIB_sectors_all - KPLIB_sectors_blufor) < 6

// TODO: TBD: also taking into consideration 'external' conditions, i.e.
// TODO: TBD:   - KPLIB_campaignRunning transit to "game over" state
// TODO: TBD:   - KPLIB_sectors_fobs from unaware to passive (?)

// TODO: TBD: 'routine' bits like refreshing timers...
// TODO: TBD: should 'just happen' during the standby/idle state...
// TODO: TBD: with brief interludes transitioning to triggered states...

class KPLIB_sectorSM_transit_toPending_base {
    targetState = "KPLIB_sectorSM_state_pending";
    condition = "true";
    onTransition = "[_this, ['KPLIB_sectorSM_transit_toPending_base', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
};

class KPLIB_sectorSM {
    list = "[] call KPLIB_fnc_sectorSM_getSectorsList";
    skipNull = 1;

    /* IDLE is a no-op state that receives all SECTORS once they have entered the state machine for the
     * first time, or have left the DEACTIVATING state, are no longer ACTIVE, and are awaiting dropping
     * out of the ACTIVE sectors array.
     */
    class KPLIB_sectorSM_state_idle {
        onStateEntered = "[_this, ['KPLIB_sectorSM_state_idle', 'onStateEntered']] call KPLIB_fnc_sectorSM_onNoOp";
        onState = "[_this, ['KPLIB_sectorSM_state_idle', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorSM_state_idle', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

        // // // TODO: TBD: IDLE really needs to transit GARRISON first and foremost
        // // Transit PENDING ASAP when we learn of the ACTIVE STATUS flag
        // class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
        //     condition = "_this in KPLIB_sectors_allActive";
        //     onTransition = "[_this, ['KPLIB_sectorSM_transit_toPending', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // GARRISON when turning ACTIVE + SHOULD
        class KPLIB_sectorSM_transit_toGarrison {
            targetState = "KPLIB_sectorSM_state_garrison";
            condition = " \
                _this in KPLIB_sectors_allActive \
                    && [_this] call KPLIB_fnc_sectors_shouldGarrison \
            ";
            onTransition = "[_this, ['KPLIB_sectorSM_transit_toGarrison', 'onTransition', 'KPLIB_sectorSM_state_garrison']] call KPLIB_fnc_sectorSM_onNoOp";
        };
    };

    // Garrison one and always hop back to consider the next event, trigger, etc
    class KPLIB_sectorSM_state_garrison {
        onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onGarrisonEntered";
        onState = "[_this, ['KPLIB_sectorSM_state_garrison', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorSM_state_garrison', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

        /* Hang out during GARRISON state until considered complete. We will not spend any time
         * in this state 'waiting' for there to be a GARRISON. We will expect that there will be.
         */
        class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
            condition = "!([_this] call KPLIB_fnc_sectors_shouldGarrison)";
            onTransition = "[_this, ['KPLIB_sectorSM_state_garrison', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
        };
    };

    // PENDING is the natural ACTIVE state for all SECTORS
    class KPLIB_sectorSM_state_pending {
        onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onPendingEntered";
        onState = "[_this] call KPLIB_fnc_sectorSM_onPending";
        onStateLeaving = "[_this, ['KPLIB_sectorSM_state_pending', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

        // CAPTURE when it may be captured
        class KPLIB_sectorSM_transit_toCaptured {
            targetState = "KPLIB_sectorSM_state_captured";
            condition = "[_this] call KPLIB_fnc_sectors_canCapture";
            onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_state_captured']] call KPLIB_fnc_sectorSM_onNoOp";
        };

        // Otherwise may transit IDLE upon timer having elapsed
        class KPLIB_sectorSM_transit_toIdle {
            targetState = "KPLIB_sectorSM_state_idle";
            condition = " \
                !([_this] call KPLIB_fnc_sectors_canActivate) \
                    && ([_this, 'KPLIB_sectors_timer', [] call KPLIB_fnc_sectors_getDeactivationTimer] call KPLIB_fnc_namespace_timerHasElapsed) \
            ";
            onTransition = "[_this, 'KPLIB_sectorSM_state_pending', 'KPLIB_sectorSM_state_idle'] call KPLIB_fnc_sectorSM_onTransit";
        };

        // /* Garrison hundred percent of the time when the flag is raised. The CONDITION is a bit tricky,
        //  * and is a reflection of whether UNITS+ASSETS have truly seen the GARRISON phase.
        //  */
        // class KPLIB_sectorSM_transit_toGarrison {
        //     targetState = "KPLIB_sectorSM_state_garrison";
        //     condition = "[_this] call KPLIB_fnc_sectors_shouldGarrison";
        //     onTransition = "[_this, ['KPLIB_sectorSM_transit_toGarrison', 'onTransition', 'KPLIB_sectorSM_state_garrison']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // // TODO: TBD: we use simple stochastic triggering throughout here...
        // // TODO: TBD: perhaps we also (re-)introduce awareness/strength/civrep biases along similar lines with the initial FSM sketch...
        // class KPLIB_sectorSM_transit_toDeactivating {
        //     targetState = "KPLIB_sectorSM_state_deactivating";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([_this] call KPLIB_fnc_sectors_canActivate) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_state_deactivating']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // // TODO: TBD: along similar lines reworking the conditions, will reconsider how we connect with the missions...
        // // Call in resistance, reinforce, etc, when the corresponding flag was raised
        // class KPLIB_sectorSM_trigger_resistanceEvent {
        //     targetState = "KPLIB_sectorSM_event_onResistance";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_resistingResisted, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, abs KPLIB_enemies_civRep, KPLIB_param_enemies_maxCivRep, KPLIB_param_sectors_arity_resistance] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onResistance']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // class KPLIB_sectorSM_trigger_reinforceEvent {
        //     targetState = "KPLIB_sectorSM_event_onReinforce";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_reinforcingReinforced, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_strength, KPLIB_param_enemies_maxStrength, KPLIB_param_sectors_arity_reinforce] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onReinforce']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // class KPLIB_sectorSM_trigger_patrolEvent {
        //     targetState = "KPLIB_sectorSM_event_onPatrolMission";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_awareness, KPLIB_param_enemies_maxAwareness, KPLIB_param_sectors_arity_patrol] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onPatrolMission']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // class KPLIB_sectorSM_trigger_antiAirMission {
        //     targetState = "KPLIB_sectorSM_event_onAntiAirMission";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_awareness, KPLIB_param_enemies_maxAwareness, KPLIB_param_sectors_arity_antiAir] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onAntiAirMission']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // // TODO: TBD: may want to refactor stochastic threshold calculations to core/common module...
        // // TODO: TBD: since it is likely to help not only here, but also during mission/garrisons in general...
        // class KPLIB_sectorSM_trigger_closeAirSupportMission {
        //     targetState = "KPLIB_sectorSM_event_onCloseAirSupportMission";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_strength, KPLIB_param_enemies_maxStrength, KPLIB_param_sectors_arity_closeAirSupport] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onCloseAirSupportMission']] call KPLIB_fnc_sectorSM_onNoOp";
        // };

        // class KPLIB_sectorSM_trigger_combatAirPatrolMission {
        //     targetState = "KPLIB_sectorSM_event_onCombatAirPatrolMission";
        //     condition = " \
        //         ([_this, 'KPLIB_sectors_timer'] call KPLIB_fnc_namespace_timerHasElapsed) \
        //             && !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_awareness, KPLIB_param_enemies_maxAwareness, KPLIB_param_sectors_arity_combatAirPatrol] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this, ['KPLIB_sectorSM_state_pending', 'onTransition', 'KPLIB_sectorSM_event_onCombatAirPatrolMission']] call KPLIB_fnc_sectorSM_onNoOp";
        // };
    };

    // Sector CAPTURED does not necessarily mean DEACTIVATED or IDLE, may still be occupied by OPFOR+BLUFOR
    // Just go ahead and CAPTURE the SECTOR when it CAN_CAPTURE
    class KPLIB_sectorSM_state_captured {
        onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onCapturedEntered";
        onState = "[_this, ['KPLIB_sectorSM_state_captured', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorSM_state_captured', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

        // // TODO: TBD: reconsider how we connect with missions...
        // class KPLIB_sectorSM_trigger_counterAttackMission : KPLIB_sectorSM_transit_toPending_base {
        //     condition = " \
        //         !([KPLIB_sectorSM_objSM, KPLIB_sectors_status_counterAttack, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
        //             && ([_this, KPLIB_enemies_strength, KPLIB_param_enemies_maxStrength, KPLIB_param_sectors_arity_counterAttack] call KPLIB_fnc_sectorSM_getStochasticTrigger) \
        //     ";
        //     onTransition = "[_this] call KPLIB_fnc_sectorSM_onCounterAttackMissionTriggered";
        // };

        // May toggle whether CAPTURING considering defender proximity etc
        class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorSM_state_captured', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
        };
    };

    // // Perform deactivation, does all but actually GC the namespace itself
    // class KPLIB_sectorSM_state_deactivating {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onDeactivatingEntered";
    //     onState = "[_this] call KPLIB_fnc_sectorSM_onDeactivating";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_state_deactivating', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     // Simply revert to IDLE state when SECTOR no longer considered ACTIVE
    //     class KPLIB_sectorSM_transit_toIdle {
    //         targetState = "KPLIB_sectorSM_state_idle";
    //         condition = "!([_this, KPLIB_sectors_status_active, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus)";
    //         onTransition = "[_this, 'KPLIB_sectorSM_state_deactivating', 'KPLIB_sectorSM_state_idle'] call KPLIB_fnc_sectorSM_onTransit";
    //     };

    //     // May toggle whether DEACTIVATING considering attacker proximity etc
    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         condition = "([_this] call KPLIB_fnc_sectors_canActivate)";
    //         onTransition = "[_this, 'KPLIB_sectorSM_state_deactivating', 'KPLIB_sectorSM_state_pending'] call KPLIB_fnc_sectorSM_onTransit";
    //     };
    // };

    // // // TODO: TBD: putting sector SM 'missions' on the side burner for the time being...
    // // May spawn and which side alignment is regulated by other bits
    // class KPLIB_sectorSM_event_onResistance {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onResistanceEntered";
    //     onState = "[_this] call KPLIB_fnc_sectorSM_onResistance";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onResistance', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     // Similarly, hang out here until RESISTANCE is fully in and flagged RESISTED
    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         condition = " \
    //             [_this, KPLIB_sectors_status_resisted, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus \
    //         ";
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onResistance', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // // TODO: TBD: with reinforce being one flag, one of several choices, infantry, mechanized, paratroopers
    // class KPLIB_sectorSM_event_onReinforce {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onReinforceEntered";
    //     onState = "[_this] call KPLIB_fnc_sectorSM_onReinforce";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onReinforce', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     // Similarly, hang out here until REINFORCE is fully in and flagged REINFORCED
    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         condition = " \
    //             [_this, KPLIB_sectors_status_reinforced, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus \
    //         ";
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onReinforce', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // class KPLIB_sectorSM_event_onPatrolMission {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onPatrolMissionEntered";
    //     onState = "[_this, ['KPLIB_sectorSM_event_onPatrolMission', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onPatrolMission', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onPatrolMission', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // class KPLIB_sectorSM_event_onCloseAirSupportMission {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onCloseAirSupportMissionEntered";
    //     onState = "[_this, ['KPLIB_sectorSM_event_onCloseAirSupportMission', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onCloseAirSupportMission', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onCloseAirSupportMission', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // class KPLIB_sectorSM_event_onCombatAirPatrolMission {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onCombatAirPatrolMissionEntered";
    //     onState = "[_this, ['KPLIB_sectorSM_event_onCombatAirPatrolMission', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onCombatAirPatrolMission', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onCombatAirPatrolMission', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // class KPLIB_sectorSM_event_onAntiAirMission {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onAntiAirMissionEntered";
    //     onState = "[_this, ['KPLIB_sectorSM_event_onAntiAirMission', 'onState']] call KPLIB_fnc_sectorSM_onNoOp";
    //     onStateLeaving = "[_this, ['KPLIB_sectorSM_event_onAntiAirMission', 'onStateLeaving']] call KPLIB_fnc_sectorSM_onNoOp";

    //     class KPLIB_sectorSM_transit_toPending : KPLIB_sectorSM_transit_toPending_base {
    //         onTransition = "[_this, ['KPLIB_sectorSM_event_onAntiAirMission', 'onTransition', 'KPLIB_sectorSM_state_pending']] call KPLIB_fnc_sectorSM_onNoOp";
    //     };
    // };

    // // TODO: TBD: may consider better comprehension over 'game won' versus 'game lost' ...
    // GAME OVER is considered 'terminal', may enjoy scrolling credits, etc; admin should re-set to next mission
    class KPLIB_sectorSM_event_onGameOver {
        onStateEntered = "[_this] call KPLIB_fnc_sectorSM_onGameOverEntered";
        onState = "[_this] call KPLIB_fnc_sectorSM_onGameOver";
    };
};
