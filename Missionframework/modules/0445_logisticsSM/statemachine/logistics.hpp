/*
    KPLIB_fnc_logisticsSM_onPostInit

    File: fn_logisticsSM_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        "Broadcast" is always the default disposition for most states, transitions.
        Why is that; glad you asked. Because in most cases, there is a timer that is
        otherwise moving, whether or not anything actually "happened" in response to
        the timer, having elapsed or otherwise. That alone needs to be informed. What
        we might do is include a broadcast period so that as we do pass through the
        broadcast state, we are only informing every so often, and not with every pass.

    Parameters:
        NONE

    Returns:
        NONE
 */

// TODO: TBD: add a logistics namespace "broadcast timer" variable, along the same lines as with production...
// TODO: TBD: in the interest of not hammering the client/server messaging...

// TODO: TBD: so, there are some considerations in play re: aborting, abandoned, etc...
// TODO: TBD: but otherwise, the approach is pretty straightforward...
// TODO: TBD: and this is not that complicated of a thing especially keeping ALPHA and BRAVO endpoints straight

class KPLIB_logisticsSM_transition_toSemperStandby {
    targetState = "KPLIB_logisticsSM_state_standby";
    condition = "true";
};

class KPLIB_logisticsSM {
    list = "KPLIB_fnc_logisticsSM_getList";
    skipNull = 1;

    class KPLIB_logisticsSM_state_rebasing {
        onStateEntered = "KPLIB_fnc_logisticsSM_onRebasingEntered";

        class KPLIB_logisticsSM_transition_toStandby {
            targetState = "KPLIB_logisticsSM_state_standby";
            condition = "true";
        };
    };

    class KPLIB_logisticsSM_state_standby {
        onState = "KPLIB_fnc_logisticsSM_onStandby";
        
        class KPLIB_logisticsSM_transition_toLoading {
            targetState = "KPLIB_logisticsSM_state_loading";
            condition = "[_this, KPLIB_logistics_status_loading] call KPLIB_fnc_logisticsSM_checkStatus";
        };

        class KPLIB_logisticsSM_transition_toUnloading {
            targetState = "KPLIB_logisticsSM_state_unloading";
            condition = "[_this, KPLIB_logistics_status_unloading] call KPLIB_fnc_logisticsSM_checkStatus";
        };

        class KPLIB_logisticsSM_transition_toRouteBlocked {
            targetState = "KPLIB_logisticsSM_state_routeBlocked";
            condition = "[_this, KPLIB_logistics_status_routeBlocked] call KPLIB_fnc_logisticsSM_checkStatus";
        };

        class KPLIB_logisticsSM_transition_toEnRouteOrAborting {
            targetState = "KPLIB_logisticsSM_state_enRouteOrAborting";
            condition = "[_this, KPLIB_logistics_status_enRouteAborting] call KPLIB_fnc_logisticsSM_checkStatus";
        };

        class KPLIB_logisticsSM_transition_toAmbushed {
            targetState = "KPLIB_logisticsSM_state_ambushed";
            condition = "[_this, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logisticsSM_checkStatus";
        };
    };

    class KPLIB_logisticsSM_state_loading {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onLoading";

        // TODO: TBD: consider the transitions, conditions, etc...
        class KPLIB_logisticsSM_transition_toStandby
            : KPLIB_logisticsSM_transition_toSemperStandby {
        };
    };

    /* Either after having naturally arrived, i.e. 'en route'... Or 'onAbortingUnloading', for
     * the same effect... Additionally, we may be "unloading" when 'abandoned', as long as there
     * is storage at that position to receive the resources. Otherwise, the manager has no other
     * choice but to "abort" to the ALPHA endpoint. */
    class KPLIB_logisticsSM_state_unloading {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onUnloading";

        class KPLIB_logisticsSM_transition_toStandby
            : KPLIB_logisticsSM_transition_toSemperStandby {
        };
    };

    class KPLIB_logisticsSM_state_enRouteOrAborting {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onEnRouteOrAborting";

        class KPLIB_logisticsSM_transition_toStandby
            : KPLIB_logisticsSM_transition_toSemperStandby {
        };
    };

    // TODO: TBD: need to also consider logistics paths which cross bodies of water...
    // TODO: TBD: i.e. what/whether to consider for "nearest" bits...
    class KPLIB_logisticsSM_state_enRouteBlocked {
        onState = "[_this] call KPLIB_fnc_logisticsSM_onEnRouteBlocked";

        // TODO: TBD: clears when, 1. blockage is removed, i.e. sector converted, or, 2. abort change order is received
        class KPLIB_logisticsSM_transition_toStandby
            : KPLIB_logisticsSM_transition_toSemperStandby {
        };
    };

    // TODO: TBD: will pick these states up later, pending research into the "missions" area...
    // TODO: TBD: i.e. with "ambushed" potentially being one of those missions...
    class KPLIB_logisticsSM_state_enRouteOrAbortingAmbushed {
    };

    // TODO: TBD: ...
};
