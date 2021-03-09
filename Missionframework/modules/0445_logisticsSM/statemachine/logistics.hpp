/*
    KPLIB_fnc_logisticsSM_onPostInit

    File: fn_logisticsSM_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-03-05 10:59:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

class KPLIB_logisticsSM {
    list = "[] call KPLIB_fnc_logisticsSM_onGetList";
    skipNull = 1;

    class KPLIB_logisticsSM_state_rebasing {
        onStateEntered = "KPLIB_fnc_logisticsSM_onRebasingEntered";
        onState = "[_this, 'rebasing'] call KPLIB_fnc_logisticsSM_onNoOp";

        class KPLIB_logisticsSM_transit_onStandby {
            targetState = "KPLIB_logisticsSM_state_standby";
            condition = "[_this] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onstandby'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        class KPLIB_logisticsSM_transit_onRebasePending {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "!([_this] call KPLIB_fnc_logisticsSM_checkStatus)";
            onTransition = "[_this, 'onrebasepending'] call KPLIB_fnc_logisticsSM_onNoOp";
        };
    };

    class KPLIB_logisticsSM_state_standby {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onStandby";

        class KPLIB_logisticsSM_transition_toPendingLoading {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_loading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onpendingloading'] call KPLIB_fnc_logisticsSM_onNoOp";
        };
    };

    class KPLIB_logisticsSM_state_pending {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onPending";

        class KPLIB_logisticsSM_transit_onLoading {
            targetState = "KPLIB_logisticsSM_state_loading";
            condition = "[_this] call KPLIB_fnc_logisticsSM_timerHasElapsed \
                && [_this, KPLIB_logistics_status_loading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onloading'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        class KPLIB_logisticsSM_transit_onEnRoute {
            targetState = "KPLIB_logisticsSM_state_enRoute";
            condition = "[_this, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onenroute'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        class KPLIB_logisticsSM_transit_onUnloading {
            targetState = "KPLIB_logisticsSM_state_unloading";
            condition = "[_this] call KPLIB_fnc_logisticsSM_timerHasElapsed \
                && [_this, KPLIB_logistics_status_unloading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onunloading'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        // TODO: TBD: also, eventually, AMBUSHED
        // TODO: TBD: also, eventually, ABANDONED
    };

    class KPLIB_logisticsSM_state_loading {
        onStateEntered = "[_this] call KPLIB_fnc_logisticsSM_onLoadingEntering";
        onState = "[_this, 'loading'] call KPLIB_fnc_logisticsSM_onNoOp";

        // Held up due to NO_RESOURCE
        class KPLIB_logisticsSM_transit_onPendingNoResource {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_noResource] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onpendingnoresource'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        // LOADING phase complete, still LOADING
        class KPLIB_logisticsSM_transit_onPendingLoading {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_loading] call KPLIB_fnc_logisticsSM_checkStatus \
                && !([_this, KPLIB_logistics_status_noResource] call KPLIB_fnc_logisticsSM_checkStatus)";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onPendingLoading";
        };

        // LOADING phase complete, kick it over to EN_ROUTE
        class KPLIB_logisticsSM_transit_onPendingEnRoute {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onPendingEnRoute";
        };
    };

    class KPLIB_logisticsSM_state_enRoute {
        onStateEntered = "[_this] call KPLIB_fnc_logisticsSM_onEnRouteEntered";
        onState = "[_this, 'enroute'] call KPLIB_fnc_logisticsSM_onNoOp";

        class KPLIB_logisticsSM_onContinueMission {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logisticsSM_checkStatus \
                && !([_this, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logisticsSM_checkStatus)";
            onTransition = "[_this, 'oncontinuemission'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        class KPLIB_logisticsSM_transit_onRouteBlocked {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_routeBlocked] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onrouteblocked'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        // Always cycle through at least one such UNLOADING phase
        class KPLIB_logisticsSM_transit_onPendingUnloading {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_unloading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onPendingUnloading";
        };

        // // TODO: TBD: future use...
        // class KPLIB_logisticsSM_transit_onAmbushed {
        //     targetState = "KPLIB_logisticsSM_state_ambushed"
        //     condition = "[_this, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logisticsSM_checkStatus \
        //         && [_this] call KPLIB_fnc_logisticsSM_shouldAmbush"
        // };
    };

    /* Either after having naturally arrived, i.e. 'en route'... Or 'onAbortingUnloading', for
     * the same effect... Additionally, we may be "unloading" when 'abandoned', as long as there
     * is storage at that position to receive the resources. Otherwise, the manager has no other
     * choice but to "abort" to the ALPHA endpoint. */

    class KPLIB_logisticsSM_state_unloading {
        onStateEntered = "[_this] call KPLIB_fnc_logisticsSM_onUnloadingEntered";
        onState = "[_this, 'unloading'] call KPLIB_fnc_logisticsSM_onNoOp";

        class KPLIB_logisticsSM_transit_onPendingNoSpace {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_noSpace] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this, 'onpendingnospace'] call KPLIB_fnc_logisticsSM_onNoOp";
        };

        class KPLIB_logisticsSM_transit_onPendingUnloading {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_unloading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onPendingUnloading";
        };

        class KPLIB_logisticsSM_transit_onConfirmReturn {
            targetState = "KPLIB_logisticsSM_state_pending";
            condition = "[_this, KPLIB_logistics_status_loading] call KPLIB_fnc_logisticsSM_checkStatus";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onConfirmReturn";
        };

        class KPLIB_logisticsSM_transit_onStandby {
            targetState = "KPLIB_logisticsSM_state_standby";
            condition = "[_this] call KPLIB_fnc_logisticsSM_checkStatus \
                && !([_this, KPLIB_logistics_status_unloading] call KPLIB_fnc_logisticsSM_checkStatus)";
            onTransition = "[_this] call KPLIB_fnc_logisticsSM_onAbortComplete";
        };
    };

    // // TODO: TBD: will pick these states up later, pending research into the "missions" area...
    // // TODO: TBD: i.e. with "ambushed" potentially being one of those missions...
    //class KPLIB_logisticsSM_state_ambushed {
    //    // TODO: TBD: which we should then kick off an ambushed mission...
    //};

    //class KPLIB_logisticsSM_state_abandoned {
    //};

    // TODO: TBD: ...
};
