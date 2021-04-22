/*
    Configuration based CBA state machine.

    File: sectors.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 14:52:19
    Last Update: 2021-04-22 15:07:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

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

class KPLIB_sectorsSM_transit_toPending_base {
    targetState = "KPLIB_sectorsSM_state_pending";
    condition = "true";
    onTransition = "[_this, ['KPLIB_sectorsSM_transit_toPending_base', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
};

class KPLIB_sectorsSM {
    list = "[] call KPLIB_fnc_sectorsSM_getSectorsList";
    skipNull = 1;

    class KPLIB_sectorsSM_state_pending {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onPendingEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onPending";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_pending', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Garrison hundred percent of the time when the flag is raised
        class KPLIB_sectorsSM_transit_toGarrison {
            targetState = "KPLIB_sectorsSM_state_garrison";
            condition = " \
                !([_this, KPLIB_sectors_status_garrisoned, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_transit_toGarrison', 'onTransition', 'KPLIB_sectorsSM_state_garrison']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_transit_toCapturing {
            targetState = "KPLIB_sectorsSM_state_capturing";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && ([_this, KPLIB_sectors_status_capturing, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && !([_this, KPLIB_sectors_status_captured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_state_capturing']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // TODO: TBD: we use simple stochastic triggering throughout here...
        // TODO: TBD: perhaps we also (re-)introduce awareness/strength/civrep biases along similar lines with the initial FSM sketch...
        class KPLIB_sectorsSM_transit_toDeactivating {
            targetState = "KPLIB_sectorsSM_state_deactivating";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && ([_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && !([_this, KPLIB_sectors_status_deactivated, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_state_deactivating']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // Call in resistance, reinforce, etc, when the corresponding flag was raised
        class KPLIB_sectorsSM_trigger_resistanceEvent {
            targetState = "KPLIB_sectorsSM_event_onResistance";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([_this, KPLIB_sectors_status_resistingResisted, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, abs KPLIB_enemy_civRep, KPLIB_param_enemy_maxCivRep, KPLIB_param_sectors_arity_resistance] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onResistance']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_reinforceEvent {
            targetState = "KPLIB_sectorsSM_event_onReinforce";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([_this, KPLIB_sectors_status_reinforcingReinforced, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_strength, KPLIB_param_enemy_maxStrength, KPLIB_param_sectors_arity_reinforce] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onReinforce']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_patrolEvent {
            targetState = "KPLIB_sectorsSM_event_onPatrolMission";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([_this, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_awareness, KPLIB_param_enemy_maxAwareness, KPLIB_param_sectors_arity_patrol] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onPatrolMission']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_antiAirMission {
            targetState = "KPLIB_sectorsSM_event_onAntiAirMission";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_awareness, KPLIB_param_enemy_maxAwareness, KPLIB_param_sectors_arity_antiAir] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onAntiAirMission']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // TODO: TBD: may want to refactor stochastic threshold calculations to core/common module...
        // TODO: TBD: since it is likely to help not only here, but also during mission/garrisons in general...
        class KPLIB_sectorsSM_trigger_closeAirSupportMission {
            targetState = "KPLIB_sectorsSM_event_onCloseAirSupportMission";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_strength, KPLIB_param_enemy_maxStrength, KPLIB_param_sectors_arity_closeAirSupport] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onCloseAirSupportMission']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_combatAirPatrolMission {
            targetState = "KPLIB_sectorsSM_event_onCombatAirPatrolMission";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_awareness, KPLIB_param_enemy_maxAwareness, KPLIB_param_sectors_arity_combatAirPatrol] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onCombatAirPatrolMission']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // Garrison one and always hop back to consider the next event, trigger, etc
    class KPLIB_sectorsSM_state_garrison {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onGarrisonEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onGarrison";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_garrison', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Hang out during GARRISON state until considered complete
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                [_this, KPLIB_sectors_status_garrisoned, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_garrison', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_state_capturing {
        onStateEntered = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onStateEntered']] call KPLIB_fnc_sectorsSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onCapturing";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Identify when the sector is CAPTURED and transition
        class KPLIB_sectorsSM_transit_toCaptured {
            targetState = "KPLIB_sectorsSM_state_captured";
            condition = " \
                ([_this, KPLIB_sectors_status_capturing, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_sectors_status_captured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onTransition', 'KPLIB_sectorsSM_state_captured']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // Fall back to PENDING when CAPTURING status has dropped
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                !([_this, KPLIB_sectors_status_capturing, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_state_captured {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onCapturedEntered";
        onState = "[_this, ['KPLIB_sectorsSM_state_captured', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_captured', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_trigger_counterAttackMission : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                !([_this, KPLIB_sectors_status_counterAttack, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_strength, KPLIB_param_enemy_maxStrength, KPLIB_param_sectors_arity_counterAttack] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this] call KPLIB_fnc_sectorsSM_onCounterAttackMissionTriggered";
        };

        // May toggle whether CAPTURING considering defender proximity etc
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorsSM_state_captured', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // Perform deactivation, does all but actually GC the namespace itself
    class KPLIB_sectorsSM_state_deactivating {
        onStateEntered = "[_this, ['KPLIB_sectorsSM_state_deactivating', 'onStateEntered']] call KPLIB_fnc_sectorsSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onDeactivating";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_deactivating', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_transit_toDeactivated {
            targetState = "KPLIB_sectorsSM_state_deactivated";
            condition = " \
                ([_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_sectors_status_deactivated, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_deactivating', 'onTransition', 'KPLIB_sectorsSM_state_deactivated']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // May toggle whether DEACTIVATING considering attacker proximity etc
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                !([_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_deactivating', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // Deactivation complete, hang out here until GC can occur
    class KPLIB_sectorsSM_state_deactivated {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onDeactivatedEntered";
        onState = "[_this, ['KPLIB_sectorsSM_state_deactivated', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
    };

    // May spawn and which side alignment is regulated by other bits
    class KPLIB_sectorsSM_event_onResistance {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onResistanceEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onResistance";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onResistance', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Similarly, hang out here until RESISTANCE is fully in and flagged RESISTED
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                [_this, KPLIB_sectors_status_resisted, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onResistance', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // TODO: TBD: with reinforce being one flag, one of several choices, infantry, mechanized, paratroopers
    class KPLIB_sectorsSM_event_onReinforce {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onReinforceEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onReinforce";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onReinforce', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Similarly, hang out here until REINFORCE is fully in and flagged REINFORCED
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                [_this, KPLIB_sectors_status_reinforced, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onReinforce', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_event_onPatrolMission {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onPatrolMissionEntered";
        onState = "[_this, ['KPLIB_sectorsSM_event_onPatrolMission', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onPatrolMission', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onPatrolMission', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_event_onCloseAirSupportMission {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onCloseAirSupportMissionEntered";
        onState = "[_this, ['KPLIB_sectorsSM_event_onCloseAirSupportMission', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onCloseAirSupportMission', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onCloseAirSupportMission', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_event_onCombatAirPatrolMission {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onCombatAirPatrolMissionEntered";
        onState = "[_this, ['KPLIB_sectorsSM_event_onCombatAirPatrolMission', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onCombatAirPatrolMission', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onCombatAirPatrolMission', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    class KPLIB_sectorsSM_event_onAntiAirMission {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onAntiAirMissionEntered";
        onState = "[_this, ['KPLIB_sectorsSM_event_onAntiAirMission', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_onAntiAirMission', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            onTransition = "[_this, ['KPLIB_sectorsSM_event_onAntiAirMission', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // // TODO: TBD: a 'trigger' is sufficient, and we can kick off a mission object...
    // class KPLIB_sectorsSM_event_counterAttackMission {
    //     onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onCounterAttackMissionEntered";
    //     onState = "[_this, ['KPLIB_sectorsSM_event_counterAttackMission', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
    //     onStateLeaving = "[_this, ['KPLIB_sectorsSM_event_counterAttackMission', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";
    //     class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
    //         onTransition = "[_this, ['KPLIB_sectorsSM_event_counterAttackMission', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
    //     };
    // };

    // GAME OVER is considered 'terminal', may enjoy scrolling credits, etc; admin should re-set to next mission
    class KPLIB_sectorsSM_event_onGameOver {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onGameOverEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onGameOver";
    };
};

// class KPLIB_sectorsSM {
//     list = "[] call KPLIB_fnc_sectorsSM_onGetSectorList";
//     skipNull = 1;

//     // // TODO: TBD: Starting small, first thing is that we should be handling the list, activation correctly...
//     // class KPLIB_sectorsSM_state_standby {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_standby::onStateEntered'] call KPLIB_fnc_sectorsSM_onNoOp";
//     //     onState = "[_this] call KPLIB_fnc_sectorsSM_onStandby";
//     //     onStateLeaving = "[_this, 'KPLIB_sectorsSM_state_standby::onStateLeaving'] call KPLIB_fnc_sectorsSM_onNoOp";

//     //     class KPLIB_sectorsSM_transit_toCapturing {
//     //         targetState = "KPLIB_sectorsSM_state_capturing";
//     //         condition = "([_this, KPLIB_sectors_status_capturing, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
//     //             && !([_this, KPLIB_sectors_status_captured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus)";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_transit_toCapturing::onTransition'] call KPLIB_fnc_sectors_onNoOp";
//     //     };

//     //     class KPLIB_sectorsSM_transit_toDeactivating {
//     //         targetState = "KPLIB_sectorsSM_state_deactivating";
//     //         condition = "[_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_transit_toDeactivating::onTransition'] call KPLIB_fnc_sectors_onNoOp";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_capturing {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_capturing::onStateEntered'] call KPLIB_fnc_sectorsSM_onNoOp";
//     //     onState = "[_this] call KPLIB_fnc_sectorsSM_onCapturing";
//     //     onStateLeaving = "[_this, 'KPLIB_sectorsSM_state_capturing::onStateLeaving'] call KPLIB_fnc_sectorsSM_onNoOp";

//     //     class KPLIB_sectorsSM_transit_toStandby {
//     //         targetState = "KPLIB_sectorsSM_state_standby";
//     //         condition = "([_this, KPLIB_sectors_status_standby, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
//     //             || ([_this, KPLIB_sectors_status_captured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus)";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_transit_toStandby::onTransition'] call KPLIB_fnc_sectors_onNoOp";
//     //     };

//     //     class KPLIB_sectorsSM_transit_toDeactivating {
//     //         targetState = "KPLIB_sectorsSM_state_deactivating";
//     //         condition = "[_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_transit_toDeactivating::onTransition'] call KPLIB_fnc_sectors_onNoOp";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_deactivating {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_deactivating::onStateEntered'] call KPLIB_fnc_sectorsSM_onNoOp";
//     //     onState = "[_this] call KPLIB_fnc_sectorsSM_onDeactivating";
//     //     onStateLeaving = "[_this, 'KPLIB_sectorsSM_state_deactivating::onStateLeaving'] call KPLIB_fnc_sectorsSM_onNoOp";

//     //     class KPLIB_sectorsSM_transit_toStandby {
//     //         targetState = "KPLIB_sectorsSM_state_standby";
//     //         condition = "[_this, KPLIB_sectors_status_standby, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_transit_toStandby'] call KPLIB_fnc_sectors_onNoOp";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_garrison {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toStandby : KPLIB_sectorsSM_transit_toStandby_base {};
//     //     class KPLIB_sectorsSM_transit_toSurprised : KPLIB_sectorsSM_transit_toSurprised_base {};
//     //     class KPLIB_sectorsSM_transit_toDefending : KPLIB_sectorsSM_transit_toDefending_base {};
//     //     class KPLIB_sectorsSM_transit_toEngaging : KPLIB_sectorsSM_transit_toEngaging_base {};
//     //     class KPLIB_sectorsSM_transit_toEntrenching : KPLIB_sectorsSM_transit_toEntrenching_base {};
//     //     class KPLIB_sectorsSM_transit_toReinforcing : KPLIB_sectorsSM_transit_toReinforcing_base {};
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking : KPLIB_sectorsSM_transit_toCounterAttacking_base {};
//     // };

//     // class KPLIB_sectorsSM_state_surprised {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toDefending : KPLIB_sectorsSM_transit_toDefending_base {};
//     //     class KPLIB_sectorsSM_transit_toEngaging : KPLIB_sectorsSM_transit_toEngaging_base {};
//     // };

//     // class KPLIB_sectorsSM_state_defending {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toStandby : KPLIB_sectorsSM_transit_toStandby_base {};
//     //     class KPLIB_sectorsSM_transit_toEngaging : KPLIB_sectorsSM_transit_toEngaging_base {};
//     //     class KPLIB_sectorsSM_transit_toEntrenching : KPLIB_sectorsSM_transit_toEntrenching_base {};
//     //     class KPLIB_sectorsSM_transit_toReinforcing : KPLIB_sectorsSM_transit_toReinforcing_base {};
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking : KPLIB_sectorsSM_transit_toCounterAttacking_base {};
//     // };

//     // class KPLIB_sectorsSM_state_engaging {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toDefending : KPLIB_sectorsSM_transit_toDefending_base {};
//     //     class KPLIB_sectorsSM_transit_toEntrenching : KPLIB_sectorsSM_transit_toEntrenching_base {};
//     // };

//     // class KPLIB_sectorsSM_state_entrenching {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toEngaging : KPLIB_sectorsSM_transit_toEngaging_base {};
//     //     class KPLIB_sectorsSM_transit_toReinforcing : KPLIB_sectorsSM_transit_toReinforcing_base {};
//     // };

//     // class KPLIB_sectorsSM_state_reinforcing {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toStandby : KPLIB_sectorsSM_transit_toStandby_base {};
//     //     class KPLIB_sectorsSM_transit_toSurprised : KPLIB_sectorsSM_transit_toSurprised_base {};
//     //     class KPLIB_sectorsSM_transit_toDefending : KPLIB_sectorsSM_transit_toDefending_base {};
//     //     class KPLIB_sectorsSM_transit_toEngaging : KPLIB_sectorsSM_transit_toEngaging_base {};
//     //     class KPLIB_sectorsSM_transit_toEntrenching : KPLIB_sectorsSM_transit_toEntrenching_base {};
//     //     class KPLIB_sectorsSM_transit_toReinforcing : KPLIB_sectorsSM_transit_toReinforcing_base {};
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking : KPLIB_sectorsSM_transit_toCounterAttacking_base {};
//     // };

//     // class KPLIB_sectorsSM_state_counterAttacking {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     // };

//     // class KPLIB_sectorsSM_state_standby {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "";
//     //         condition = "";
//     //         onTransition = "";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEngaging {
//     //         targetState = "";
//     //         condition = "";
//     //         onTransition = "";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_captured {
//     //     onStateEntered = "";
//     //     onState = "";
//     //     onStateLeaving = "";
//     //     class KPLIB_sectorsSM_transit_toStandby : KPLIB_sectorsSM_transit_toStandby_base {};
//     // };




//     // class KPLIB_sectorsSM_state_standby {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_standby'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onStandby";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_standby] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toSurprised {
//     //         targetState = "KPLIB_sectorsSM_state_surprised";
//     //         condition = "[_this, KPLIB_enemy_status_surprised, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toSurprised'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_deactivating {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_deactivating'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onDeactivating";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_deactivating] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     // };

//     // class KPLIB_sectorsSM_state_surprised {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_surprised'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onSurprised";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_surprised] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toStandby {
//     //         targetState = "KPLIB_sectorsSM_state_standby";
//     //         condition = "[_this, KPLIB_enemy_status_standby, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toStandby'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toReinforcing {
//     //         targetState = "KPLIB_sectorsSM_state_reinforcing";
//     //         condition = "[_this, KPLIB_enemy_status_reinforcing, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toReinforcing'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking {
//     //         targetState = "KPLIB_sectorsSM_state_counterAttacking";
//     //         condition = "[_this, KPLIB_enemy_status_counterAttacking, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toCounterAttacking'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEngaging {
//     //         targetState = "KPLIB_sectorsSM_state_engaging";
//     //         condition = "[_this, KPLIB_enemy_status_engaging, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEngaging'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEntrenched {
//     //         targetState = "KPLIB_sectorsSM_state_entrenched";
//     //         condition = "[_this, KPLIB_enemy_status_entrenched, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEntrenched'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_defending {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_defending'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onDefending";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_defending] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toStandby {
//     //         targetState = "KPLIB_sectorsSM_state_standby";
//     //         condition = "[_this, KPLIB_enemy_status_standby, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toStandby'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toReinforcing {
//     //         targetState = "KPLIB_sectorsSM_state_reinforcing";
//     //         condition = "[_this, KPLIB_enemy_status_reinforcing, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toReinforcing'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking {
//     //         targetState = "KPLIB_sectorsSM_state_counterAttacking";
//     //         condition = "[_this, KPLIB_enemy_status_counterAttacking, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toCounterAttacking'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEngaging {
//     //         targetState = "KPLIB_sectorsSM_state_engaging";
//     //         condition = "[_this, KPLIB_enemy_status_engaging, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEngaging'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEntrenched {
//     //         targetState = "KPLIB_sectorsSM_state_entrenched";
//     //         condition = "[_this, KPLIB_enemy_status_entrenched, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEntrenched'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_reinforcing {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_reinforcing'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onReinforcing";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_reinforcing] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking {
//     //         targetState = "KPLIB_sectorsSM_state_counterAttacking";
//     //         condition = "[_this, KPLIB_enemy_status_counterAttacking, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toCounterAttacking'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEngaging {
//     //         targetState = "KPLIB_sectorsSM_state_engaging";
//     //         condition = "[_this, KPLIB_enemy_status_engaging, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEngaging'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEntrenched {
//     //         targetState = "KPLIB_sectorsSM_state_entrenched";
//     //         condition = "[_this, KPLIB_enemy_status_entrenched, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEntrenched'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_counterAttacking {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_counterAttacking'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onCounterAttacking";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_counterAttack] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toReinforcing {
//     //         targetState = "KPLIB_sectorsSM_state_reinforcing";
//     //         condition = "[_this, KPLIB_enemy_status_reinforcing, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toReinforcing'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEngaging {
//     //         targetState = "KPLIB_sectorsSM_state_engaging";
//     //         condition = "[_this, KPLIB_enemy_status_engaging, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEngaging'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEntrenched {
//     //         targetState = "KPLIB_sectorsSM_state_entrenched";
//     //         condition = "[_this, KPLIB_enemy_status_entrenched, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEntrenched'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_engaging {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_engaging'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onEngaging";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_engaging] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toReinforcing {
//     //         targetState = "KPLIB_sectorsSM_state_reinforcing";
//     //         condition = "[_this, KPLIB_enemy_status_reinforcing, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toReinforcing'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toCounterAttacking {
//     //         targetState = "KPLIB_sectorsSM_state_counterAttacking";
//     //         condition = "[_this, KPLIB_enemy_status_counterAttacking, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toCounterAttacking'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toEntrenched {
//     //         targetState = "KPLIB_sectorsSM_state_entrenched";
//     //         condition = "[_this, KPLIB_enemy_status_entrenched, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toEntrenched'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };

//     // class KPLIB_sectorsSM_state_entrenched {
//     //     onStateEntered = "[_this, 'KPLIB_sectorsSM_state_entrenched'] call KPLIB_fnc_sectorsSM_onStateEntered";
//     //     onState = "_this call KPLIB_fnc_sectorsSM_onEntrenched";
//     //     onStateLeaving = "[_this, KPLIB_enemy_status_entrenched] call KPLIB_fnc_sectorsSM_onStateLeaving";
//     //     class KPLIB_sectorsSM_transit_toStandby {
//     //         targetState = "KPLIB_sectorsSM_state_standby";
//     //         condition = "[_this, KPLIB_enemy_status_standby, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toStandby'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toDefending {
//     //         targetState = "KPLIB_sectorsSM_state_defending";
//     //         condition = "[_this, KPLIB_enemy_status_defending, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toDefending'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     //     class KPLIB_sectorsSM_transit_toReinforcing {
//     //         targetState = "KPLIB_sectorsSM_state_reinforcing";
//     //         condition = "[_this, KPLIB_enemy_status_reinforcing, KPLIB_sectorsSM_status] call KPLIB_fnc_namespace_checkStatus";
//     //         onTransition = "[_this, 'KPLIB_sectorsSM_state_entrenched', 'KPLIB_sectorsSM_transit_toReinforcing'] call KPLIB_fnc_sectorsSM_onTransit";
//     //     };
//     // };
// };

// states: start, passive, reinforcing, counterattacking, defending, skirmishing, laststand, unaware, exit
// simplify to: standingBy (default), defending, reinforcing, counterattacking, skirmishing, laststand

// MSTATUS(_standby)
// MSTATUS(_passive)
// MSTATUS(_defend)
// MSTATUS(_reinforce)
// MSTATUS(_counterAttack)
// MSTATUS(_skirmish)
// MSTATUS(_hunkerDown)
// MSTATUS(_unaware)

// target variables:
// status: unaware
// patrol timer; thresholds: 30 => spawm up to four (or however many) patrols
// target timer: about a 1 sec or so heartbeat
// last stand threshold: all sectors - blufor sectors <= threshold (i.e. 6)
// exit strategy: !KPLIB_campaignRunning

// TODO: TBD: re: isServer, not running this on a client, so it is redundant
// state: start
// transition: to reinforcing: when: isServer && _status contains _reinforcing
// transition: to defending: when: isServer && _status contains _defending
// transition: to passive: when: isServer && _status contains _passive
// transition: to unaware: when: isServer && _status contains _unaware
// transition: to skirmishing: when: isServer && _status contains _skirmishing
// transition: to counterattacking: when: isServer && _status contains _counterattacking
// transition: to laststand: when: isServer && _status contains _laststand
// transition: to exit: when: otherwise, true

// state: passive
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class ___Sectors____1' to defending: when: count KPLIB_sectors_blufor > 2 || count (KPLIB_sectors_blufor arrayIntersect KPLIB_sectors_military) > 0
    // _time = diag_tickTime
// transition: 'class spawn_patrol' to passive: action: 'KPLIB_enemy_patrols = KPLIB_enemy_patrols - [grpNull]': when: count KPLIB_enemy_patrols < 4
    // [getMarkerPos (KPLIB_sectors_blufor select 0), false, 2] call KPLIB_fnc_enemy_spawnPatrol; _time = diag_tickTime; _patrolTime = diag_tickTime;
// transition 'class timer' to 'passive':
    // _time = diag_tickTime

// state: reinforcing
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class enemy_sectors__' to lastStand: when diag_tickTime - _time >= 1 && count (KPLIB_sectors_all - KPLIB_sectors_blufor) < 6
    // _time = diag_tickTime
// transition: 'class aw___20_____str' to defending: when: diag_tickTime - _time >= 1 &&
//                      KPLIB_enemy_awareness <= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_reinforce, KPLIB_preset_enemy_defend, KPLIB_preset_enemy_lessOrEqual] call KPLIB_fnc_enemy_getThreshold)
//                        || KPLIB_enemy_strength <= ([KPLIB_preset_enemy_strength, KPLIB_preset_enemy_reinforce, KPLIB_preset_enemy_defend, KPLIB_preset_enemy_lessOrEqual] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class aw___50_____str' to skirmishing: when: diag_tickTime - _time >= 1 &&
//                      KPLIB_enemy_awareness >= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_reinforce, KPLIB_preset_enemy_skirmish] call KPLIB_fnc_enemy_getThreshold)
//                        || KPLIB_enemy_strength >= ([KPLIB_preset_enemy_strength, KPLIB_preset_enemy_reinforce, KPLIB_preset_enemy_skirmish] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class spawn_patrol' to reinforcing: when: diag_tickTime - _time >= 1 && diag_tickTime - _patrolTime > 30
//                      && KPLIB_enemy_patrols = KPLIB_enemy_patrols - [grpNull]; count KPLIB_enemy_patrols < 8
//                      || _patrolTime = diag_tickTime
    // [getMarkerPos (selectRandom KPLIB_sectors_blufor), selectRandom [false, false, true, true]] call KPLIB_fnc_enemy_spawnPatrol
    // _time = diag_tickTime
    // _patrolTime = diag_tickTime
// transition: 'class spawn_AA_site' to reinforcing: when: false (?)
// transition: 'class reinforce_garris' to reinforcing: when: false (?)

// state: counterattacking
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class enemy_sectors__' to lastStand: when: diag_tickTime - _time >= 1 && count (KPLIB_sectors_all - KPLIB_sectors_blufor) < 6
    // _time = diag_tickTime
// transition: 'class aw___65_' to skirmishing: when: diag_tickTime - _time >= 1
//                      && KPLIB_enemy_awareness <= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_counterattack, KPLIB_preset_enemy_skirmish, KPLIB_preset_enemy_lessOrEqual] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class spawn_patrol' to counterattacking: when: diag_tickTime - _time >= 1 && (diag_tickTime - _patrolTime) > 30
//                      && KPLIB_enemy_patrols = KPLIB_enemy_patrols - [grpNull]; (count KPLIB_enemy_patrols) < 12
//                      && _patrolTime = diag_tickTime; false
    // [getMarkerPos (selectRandom KPLIB_sectors_blufor), selectRandom [false, true, true, true], 6] call KPLIB_fnc_enemy_spawnPatrol; _time = diag_tickTime; _patrolTime = diag_tickTime;
// transition: 'class spawn_AA_site' to counterattacking: when: false (?)
// transition: 'class intercept_enemies' to counterattacking: when: false (?)
// transition: 'class start_offensive' to counterattacking: when: false (?)
// transition: 'class timer' to counterattacking: when: diag_tickTime - _time >= 1
    // _time = diag_tickTime

// state: defending
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class enemy_sectors__' to lastStand: when: diag_tickTime - _time >= 1 && count (KPLIB_sectors_all - KPLIB_sectors_blufor) < 6
    // _time = diag_tickTime
// transition: 'class aw___35_____str' to reinforcing: when: diag_tickTime - _time >= 1
//                      && KPLIB_enemy_awareness >= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_defend, KPLIB_preset_enemy_reinforce] call KPLIB_fnc_enemy_getThreshold)
//                      && KPLIB_enemy_strength >= ([KPLIB_preset_enemy_strength, KPLIB_preset_enemy_defend, KPLIB_preset_enemy_reinforce] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class spawn_patrol' to defending: when: diag_tickTime - _time >= 1 && (diag_tickTime - _patrolTime) > 30
//                      && KPLIB_enemy_patrols = KPLIB_enemy_patrols - [grpNull]; (count KPLIB_enemy_patrols) < 6
//                      || _patrolTime = diag_tickTime; false
    // [getMarkerPos (selectRandom KPLIB_sectors_blufor), selectRandom [false, false, false, true]] call KPLIB_fnc_enemy_spawnPatrol; _time = diag_tickTime; _patrolTime = diag_tickTime;
// transition: 'class spawn_AA_site' to defending: when: false (?)
// transition: 'class timer' to defending: when: diag_tickTime - _time >= 1
    // _time = diag_tickTime

// state: skirmishing
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class enemy_sectors__' to lastStand: when: diag_tickTime - _time >= 1 && count (KPLIB_sectors_all - KPLIB_sectors_blufor) < 6
    // _time = diag_tickTime
// transition: 'class aw___40_' to reinforcing: when: diag_tickTime - _time >= 1
//                      && KPLIB_enemy_awareness <= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_skirmish, KPLIB_preset_enemy_reinforce, KPLIB_preset_enemy_lessOrEqual] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class aw___75_____str' to counterattacking: when: diag_tickTime - _time >= 1
//                      && KPLIB_enemy_awareness >= ([KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_skirmish, KPLIB_preset_enemy_counterattack] call KPLIB_fnc_enemy_getThreshold)
//                      && KPLIB_enemy_strength >= ([KPLIB_preset_enemy_strength, KPLIB_preset_enemy_skirmish, KPLIB_preset_enemy_counterattack] call KPLIB_fnc_enemy_getThreshold)
    // _time = diag_tickTime
// transition: 'class spawn_patrol' to skirmishing: when: diag_tickTime - _time >= 1 && (diag_tickTime - _patrolTime) > 30
//                      && KPLIB_enemy_patrols = KPLIB_enemy_patrols - [grpNull]; (count KPLIB_enemy_patrols) < 12
//                          || _patrolTime = diag_tickTime; false;
    // [getMarkerPos (selectRandom KPLIB_sectors_blufor), selectRandom [false, true, true, true], 6] call KPLIB_fnc_enemy_spawnPatrol; _time = diag_tickTime; _patrolTime = diag_tickTime;
// transition: 'class counterattack_captured' to skirmishing: when: false (?)
// transition: 'class intercept_enemies' to skirmishing: when: false (?)
// transition: 'class spawn_AA_site' to skirmishing: when: false (?)
// transition: 'class timer' to skirmishing: when: diag_tickTime - _time >= 1
    // _time = diag_tickTime

// state: lastStand
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class timer' to lastStand: when: diag_tickTime - _time >= 1
    // _time = diag_tickTime

// state: unaware
// transition: 'class __campaignRunnin' to exit: when: !KPLIB_campaignRunning
// transition: 'class ___FOB____1_Sect' to passive: when: diag_tickTime - _time >= 1
//                      && count KPLIB_sectors_blufor > 0 && count KPLIB_sectors_fobs > 0
    // _time = diag_tickTime
// transition: 'class timer' to unaware: when: diag_tickTime - _time >= 1
    // _time = diag_tickTime

// state: exit: just that, an 'off ramp', do any cleanup of the current state
