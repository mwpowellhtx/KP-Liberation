
// ...

// Handles HUD related dispatches from server to client
class KPLIB_hudDispatchSM {
    list = "[] call KPLIB_fnc_hudDispatchSM_onGetList";
    skipNull = 1;

    class KPLIB_hudDispatchSM_standby {
        onStateEntered = "[_this, 'KPLIB_hudDispatchSM_standby::onStateEntered'] call KPLIB_fnc_hudDispatchSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_hudDispatchSM_onStandby";
        onStateLeaving = "[_this, 'KPLIB_hudDispatchSM_standby::onStateLeaving'] call KPLIB_fnc_hudDispatchSM_onNoOp";

        // When there is an update to report, then DISPATCH
        class KPLIB_hudDispatchSM_transit_toDispatch {
            condition = "!([_this] call KPLIB_fnc_hud_checkPlayerStatus)";
            onTransition = "[_this, 'KPLIB_hudDispatchSM_transit_toDispatch::onTransition'] call KPLIB_fnc_hudDispatchSM_onNoOp";
        };
    };

    class KPLIB_hudDispatchSM_dispatch {
        onStateEntered = "[_this, 'KPLIB_hudDispatchSM_dispatch::onStateEntered'] call KPLIB_fnc_hudDispatchSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_hudDispatchSM_onDispatch";
        onStateLeaving = "[_this, 'KPLIB_hudDispatchSM_dispatch::onStateLeaving'] call KPLIB_fnc_hudDispatchSM_onNoOp";

        class KPLIB_hudDispatchSM_transit_toStandby {
            condition = "[_this] call KPLIB_fnc_hud_checkPlayerStatus";
            onTransition = "[_this, 'KPLIB_hudDispatchSM_transit_toStandby::onTransition'] call KPLIB_fnc_hudDispatchSM_onNoOp";
        };
    };
};
