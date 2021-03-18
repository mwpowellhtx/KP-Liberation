
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
            onTransition = "[_this] call KPLIB_fnc_productionSM_onStandbyOrPendingTransit"
        };
    };
};
