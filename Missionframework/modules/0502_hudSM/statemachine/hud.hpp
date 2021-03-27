
// ...

// TODO: TBD: a SM may be overkill for an always 1-element array: i.e. [player]
// TODO: TBD: especially we need to sleep FPS resources back to the engine between waking up and redressing overlay

// Always kick this back to STANDBY, awaiting next STATUS REPORT
class KPLIB_hudSM_transit_toStandbyBase {
    targetState = "KPLIB_hudSM_state_standby";
    condition = "true";
    onTransition = "[_this] call KPLIB_fnc_hudSM_onTransitToStandby";
};

// Handles client side HUD related resource, object, or title aspects
class KPLIB_hudSM {
    list = "[] call KPLIB_fnc_hudSM_onGetList";
    skipNull = 1;

    class KPLIB_hudSM_state_standby {
        onStateEntered = "[_this, 'KPLIB_hudSM_state_standby::onStateEntered'] call KPLIB_fnc_hudSM_onNoOp";
        onState = "[_this] call KPLIB_fnc_hudSM_onStandby";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_standby::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toBlank {
            targetState = "KPLIB_hudSM_state_blank";
            condition = "dialog || ( \
                ([_this, KPLIB_hudSM_overlayTimer] call KPLIB_fnc_hud_hasPlayerTimerElapsed) \
                    && ([_this, KPLIB_hud_status_standby, KPLIB_hudDispatchSM_dispatchStatus] call KPLIB_fnc_hud_checkPlayerStatus)\
            )";
            onTransition = "[_this, 'KPLIB_hudSM_transit_toBlank::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };

        class KPLIB_hudSM_transit_toOverlay {
            targetState = "KPLIB_hudSM_state_overlay";
            condition = "!dialog \
                && ([_this, KPLIB_hudSM_overlayTimer] call KPLIB_fnc_hud_hasPlayerTimerElapsed) \
                && ([_this, KPLIB_hud_status_overlay, KPLIB_hudDispatchSM_dispatchStatus] call KPLIB_fnc_hud_checkPlayerStatus)";
            onTransition = "[_this, 'KPLIB_hudSM_transit_toOverlay::onTransition'] call KPLIB_fnc_hudSM_onNoOp";
        };
    };

    class KPLIB_hudSM_state_blank {
        onStateEntered = "[_this] call KPLIB_fnc_hudSM_onBlankEntered";
        onState = "[_this, 'KPLIB_hudSM_state_blank::onState'] call KPLIB_fnc_hudSM_onNoOp";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_blank::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toStandby : KPLIB_hudSM_transit_toStandbyBase {
            // Just always do this
        };
    };

    class KPLIB_hudSM_state_overlay {
        onStateEntered = "[_this] call KPLIB_fnc_hudSM_onOverlayEntered";
        onState = "[_this, 'KPLIB_hudSM_state_overlay::onState'] call KPLIB_fnc_hudSM_onNoOp";
        onStateLeaving = "[_this, 'KPLIB_hudSM_state_overlay::onStateLeaving'] call KPLIB_fnc_hudSM_onNoOp";

        class KPLIB_hudSM_transit_toStandby : KPLIB_hudSM_transit_toStandbyBase {
            // Just always do this
        };
    };
};
