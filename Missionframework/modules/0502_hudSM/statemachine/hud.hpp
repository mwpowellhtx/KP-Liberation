
// ...

class KPLIB_hudSM_transit_toStandbyBase {
    targetState = "KPLIB_hudSM_state_standby";
    condition = "!dialog && ([_this] call KPLIB_fnc_hud_checkPlayerStatus)";
    onTransition = "[_this, 'KPLIB_hudSM_transit_toStandbyBase::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
};

class KPLIB_hudSM_transit_toOverlayBase {
    targetState = "KPLIB_hudSM_state_overlay";
    condition = "!dialog && ([_this, KPLIB_hud_status_fobSectorOrAway] call KPLIB_fnc_hud_checkPlayerStatus)";
    onTransition = "[_this, 'KPLIB_hudSM_transit_toFobBase::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
};

class KPLIB_hudSM_transit_toDialogBase {
    targetState = "KPLIB_hudSM_state_dialog";
    condition = "dialog";
    onTransition = "[_this, 'KPLIB_hudSM_transit_toDialogBase::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
};

// Handles client side HUD related resource, object, or title aspects
class KPLIB_hudSM {
    list = "[] call KPLIB_fnc_hudSM_onGetList";
    skipNull = 1;

    class KPLIB_hudSM_state_standby {
        onStateEntered = "[_this, 'KPLIB_hudSM_state_standby::onStateEntered'] call KPLIB_fnc_hudSM_onNoOp";
        onState = "[_this, 'KPLIB_hudSM_state_standby::onState'] call KPLIB_fnc_hudSM_onNoOp";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_standby::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toOverlay : KPLIB_hudSM_transit_toOverlayBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toOverlay::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };

        class KPLIB_hudSM_transit_toDialog : KPLIB_hudSM_transit_toDialogBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toDialog::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };
    };

    class KPLIB_hudSM_state_overlay {
        onStateEntered = "[_this, 'KPLIB_hudSM_state_overlay::onStateEntered'] call KPLIB_fnc_hudSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_hudSM_onCutFob";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_overlay::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toStandby : KPLIB_hudSM_transit_toStandbyBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toStandby::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };

        class KPLIB_hudSM_transit_toDialog : KPLIB_hudSM_transit_toDialogBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toDialog::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };
    };

    class KPLIB_hudSM_state_dialog {
        onStateEntered = "[_this, 'KPLIB_hudSM_state_dialog::onStateEntered'] call KPLIB_fnc_hudSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_hudSM_onDialog";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_dialog::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toStandby : KPLIB_hudSM_transit_toStandbyBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toStandby::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };

        class KPLIB_hudSM_transit_toOverlay : KPLIB_hudSM_transit_toOverlayBase {
            onTransition = "[_this, 'KPLIB_hudSM_transit_toOverlay::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };
    };
};
