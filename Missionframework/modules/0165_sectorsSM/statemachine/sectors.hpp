/*
    Configuration based CBA state machine.

    File: sectors.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 14:52:19
    Last Update: 2021-04-26 14:18:30
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

    // IDLE is the natural inactive state for all SECTORS
    class KPLIB_sectorsSM_state_idle {
        onStateEntered = "[_this, ['KPLIB_sectorsSM_state_idle', 'onStateEntered']] call KPLIB_fnc_sectorsSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onIdle";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_idle', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // ACTIVE is the state machine on ramp status
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                ([_this, KPLIB_sectors_status_active, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_transit_toPending', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // PENDING is the natural ACTIVE state for all SECTORS
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
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_state_deactivating']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // Call in resistance, reinforce, etc, when the corresponding flag was raised
        class KPLIB_sectorsSM_trigger_resistanceEvent {
            targetState = "KPLIB_sectorsSM_event_onResistance";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_resistingResisted, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, abs KPLIB_enemy_civRep, KPLIB_param_enemy_maxCivRep, KPLIB_param_sectors_arity_resistance] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onResistance']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_reinforceEvent {
            targetState = "KPLIB_sectorsSM_event_onReinforce";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_reinforcingReinforced, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && ([_this, KPLIB_enemy_strength, KPLIB_param_enemy_maxStrength, KPLIB_param_sectors_arity_reinforce] call KPLIB_fnc_sectorsSM_getStochasticTrigger) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_pending', 'onTransition', 'KPLIB_sectorsSM_event_onReinforce']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        class KPLIB_sectorsSM_trigger_patrolEvent {
            targetState = "KPLIB_sectorsSM_event_onPatrolMission";
            condition = " \
                ([_this] call KPLIB_fnc_sectorsSM_timerHasElapsed) \
                    && !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_mission, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
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

    // Always prefer an incremental evaluation, handle in phases, always allowing for sitrep to refresh
    class KPLIB_sectorsSM_state_capturing {
        onStateEntered = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onStateEntered']] call KPLIB_fnc_sectorsSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onCapturing";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        // Bounce back to PENDING when sector has not been fully CAPTURED yet
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                ([_this, KPLIB_sectors_status_capturing, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
                    && !([_this, KPLIB_sectors_status_captured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };

        // Identify when the sector is CAPTURED and transition
        class KPLIB_sectorsSM_transit_toCaptured {
            targetState = "KPLIB_sectorsSM_state_captured";
            condition = " \
                ([_this, KPLIB_sectors_status_capturingCaptured, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_capturing', 'onTransition', 'KPLIB_sectorsSM_state_captured']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
    };

    // Sector CAPTURED does not necessarily mean DEACTIVATED or IDLE, may still be occupied by OPFOR+BLUFOR
    class KPLIB_sectorsSM_state_captured {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onCapturedEntered";
        onState = "[_this, ['KPLIB_sectorsSM_state_captured', 'onState']] call KPLIB_fnc_sectorsSM_onNoOp";
        onStateLeaving = "[_this, ['KPLIB_sectorsSM_state_captured', 'onStateLeaving']] call KPLIB_fnc_sectorsSM_onNoOp";

        class KPLIB_sectorsSM_trigger_counterAttackMission : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                !([KPLIB_sectorsSM_objSM, KPLIB_sectors_status_counterAttack, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
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

        // Simply revert to IDLE state when SECTOR no longer considered ACTIVE
        class KPLIB_sectorsSM_transit_toIdle {
            targetState = "KPLIB_sectorsSM_state_idle";
            condition = " \
                !([_this, KPLIB_sectors_status_active, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this] call KPLIB_fnc_sectorsSM_onDeactivatedTransition";
        };

        // May toggle whether DEACTIVATING considering attacker proximity etc
        class KPLIB_sectorsSM_transit_toPending : KPLIB_sectorsSM_transit_toPending_base {
            condition = " \
                !([_this, KPLIB_sectors_status_deactivating, 'KPLIB_sectors_status'] call KPLIB_fnc_namespace_checkStatus) \
            ";
            onTransition = "[_this, ['KPLIB_sectorsSM_state_deactivating', 'onTransition', 'KPLIB_sectorsSM_state_pending']] call KPLIB_fnc_sectorsSM_onNoOp";
        };
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

    // GAME OVER is considered 'terminal', may enjoy scrolling credits, etc; admin should re-set to next mission
    class KPLIB_sectorsSM_event_onGameOver {
        onStateEntered = "[_this] call KPLIB_fnc_sectorsSM_onGameOverEntered";
        onState = "[_this] call KPLIB_fnc_sectorsSM_onGameOver";
    };
};
