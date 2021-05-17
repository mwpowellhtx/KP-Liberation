/*
    KP LIBERATION PRODUCTION STATE MACHINE

    File: production.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-18 19:14:03
    Last Update: 2021-03-18 19:14:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines the CBA PRODUCTION UI state machine.

    Dependencies:
        0410_production
 */

class KPLIB_productionSM_transit_standbyOrPending_template {
    targetState = "KPLIB_productionSM_state_standbyOrPending";
    condition = "true";
    onTransition = "[_this, 'standbyOrPending[template]::onTransition(standbyOrPending)'] call KPLIB_fnc_productionSM_onNoOp";
};

class KPLIB_productionSM {
    list = "[] call KPLIB_fnc_productionSM_onGetList";
    skipNull = 1;

    /* All CBA PRODUCTION namespace are routed through a REBASE opportunity, following which,
     * the STATE MACHINE forks either to STANDBY or PENDING, depending on whether there is a
     * running timer.
     */
    class KPLIB_productionSM_state_rebase {
        onStateEntered = "[_this] call KPLIB_fnc_productionSM_onRebaseEntered;";
        onState = "[_this, 'rebase::onState'] call KPLIB_fnc_productionSM_onNoOp";
        onStateLeaving = "[_this, 'rebase::onStateLeaving'] call KPLIB_fnc_productionSM_onNoOp";

        class KPLIB_productionSM_transit_standbyOrPending
            : KPLIB_productionSM_transit_standbyOrPending_template {
        };
    };

    class KPLIB_productionSM_state_standbyOrPending {
        onStateEntered = "[_this, 'standbyOrPending::onStateEntered'] call KPLIB_fnc_productionSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_productionSM_onStandbyOrPending";
        onStateLeaving = "[_this, 'standbyOrPending::onStateLeaving'] call KPLIB_fnc_productionSM_onNoOp";

        class KPLIB_productionSM_transit_production {
            targetState = "KPLIB_productionSM_state_production";
            condition = "[_this] call KPLIB_fnc_productionSM_hasElapsedTimer";
            onTransition = "[_this, 'standbyOrPending::onTransition(production)'] call KPLIB_fnc_productionSM_onNoOp";
        };
    };

    class KPLIB_productionSM_state_production {
        onStateEntered = "[_this] call KPLIB_fnc_productionSM_onProductionEntered";
        onState = "[_this, 'production::onState'] call KPLIB_fnc_productionSM_onNoOp";
        onStateLeaving = "[_this, 'production::onStateLeaving'] call KPLIB_fnc_productionSM_onNoOp";

        class KPLIB_productionSM_transit_standbyOrPending
            : KPLIB_productionSM_transit_standbyOrPending_template {
            onTransition = "[_this] call KPLIB_fnc_productionSM_onStandbyOrPendingTransit";
        };
    };
};
