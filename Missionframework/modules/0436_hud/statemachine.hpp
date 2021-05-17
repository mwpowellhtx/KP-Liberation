/*
    File: statemachine.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 13:45:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No
 */

// TODO: TBD: we really need to get away from state machines here...
// TODO: TBD: instead each HUD, client+server, needs to stand alone...
// TODO: TBD: players can register with a registry and be dispatched updates separately...
// TODO: TBD: maybe we also run these with triggers (?) that might be interesting....

// Handles HUD related dispatches from server to client
class KPLIB_hudSM {
    list = "[] call KPLIB_fnc_hudSM_onGetList";
    skipNull = 1;

    class KPLIB_hudSM_standby {
        onStateEntered = "[_this] call KPLIB_fnc_hudSM_onStandbyEntered";
        onState = "[_this] call KPLIB_fnc_hudSM_onStandby";
        onStateLeaving = "[_this, 'KPLIB_hudSM_standby::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        // When there is an update to report, then DISPATCH
        class KPLIB_hudSM_transit_toDispatch {
            targetState = "KPLIB_hudSM_dispatch";
            // The condition is fine, ANY report, including NO REPORT, is acceptable
            condition = "([_this] call KPLIB_fnc_hud_hasPlayerTimerElapsed) && !([_this] call KPLIB_fnc_hud_checkPlayerStatus)";
            onTransition = "[_this] call KPLIB_fnc_hudSM_onCompileReport";
        };
    };

    class KPLIB_hudSM_dispatch {
        onStateEntered = "[_this] call KPLIB_fnc_hudSM_onDispatchEntered";
        onState = "[_this, 'KPLIB_hudSM_dispatch::onState'] call KPLIB_fnc_hudSM_onNoOp";
        onStateLeaving = "[_this, 'KPLIB_hudSM_dispatch::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        // DISPATCH then transit ALWAYS
        class KPLIB_hudSM_transit_toStandby {
            targetState = "KPLIB_hudSM_standby";
            condition = "true";
            onStateEntered = "[_this, 'KPLIB_hudSM_transit_toStandby::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };
    };
};
