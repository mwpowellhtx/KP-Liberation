/*
    KPLIB MISSIONS STATE MACHINE

    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-03-15 21:01:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines the CBA MISSIONS state machine by configuration.

    Parameters:
        NONE

    Returns:
        NONE
 */

class KPLIB_missionsSM {
    list = "[] call KPLIB_fnc_missionsSM_onGetList";
    skipNull = 1;

    class KPLIB_missionsSM_state_setup {
        onStateEntered = "[_this, 'KPLIB_fnc_mission_onSetupEntered'] call KPLIB_fnc_missionsSM_onSetupEntered";
        onState = "[_this, 'KPLIB_fnc_mission_onSetup'] call KPLIB_fnc_missionsSM_onSetup";
        onStateLeaving = "[_this, 'KPLIB_fnc_mission_onSetupLeaving'] call KPLIB_fnc_missionsSM_onSetupLeaving";

        class KPLIB_missionsSM_transit_toMission {
            targetState = "KPLIB_missionsSM_state_mission";
            condition = "[_this, KPLIB_mission_status_started] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'setup::transit::toMission'] call KPLIB_fnc_missionsSM_onNoOp";
        };

        class KPLIB_missionsSM_transit_toAborting {
            targetState = "KPLIB_missionsSM_state_tearDown";
            condition = "[_this, KPLIB_mission_status_aborting] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'setup::transit::toTearDown'] call KPLIB_fnc_missionsSM_onNoOp";
        };
    };

    class KPLIB_missionsSM_state_mission {
        onStateEntered = "[_this, 'KPLIB_fnc_mission_onMissionEntered'] call KPLIB_fnc_missionsSM_onMissionEntered";
        onState = "[_this, 'KPLIB_fnc_mission_onMission', KPLIB_mission_status_successFailureAborting] call KPLIB_fnc_missionsSM_onMission";
        onStateLeaving = "[_this, 'KPLIB_fnc_mission_onMissionLeaving'] call KPLIB_fnc_missionsSM_onMissionLeaving";

        class KPLIB_missionsSM_transit_toTearDown {
            targetState = "KPLIB_missionsSM_state_tearDown";
            condition = "[_this, KPLIB_mission_status_successFailureAborting] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'mission::transit::toTearDown'] call KPLIB_fnc_missionsSM_onNoOp";
        };
    };

    class KPLIB_missionsSM_state_tearDown {
        onStateEntered = "[_this, 'KPLIB_fnc_mission_onTearDownEntered'] call KPLIB_fnc_missionsSM_onTearDownEntered";
        onState = "[_this, 'KPLIB_fnc_mission_onTearDown', KPLIB_mission_status_completed] call KPLIB_fnc_missionsSM_onTearDown";
        onStateLeaving = "[_this, 'KPLIB_fnc_mission_onTearDownLeaving'] call KPLIB_fnc_missionsSM_onTearDownLeaving";

        class KPLIB_missionsSM_transit_toComplete {
            targetState = "KPLIB_missionsSM_state_complete";
            condition = "[_this, KPLIB_mission_status_completed] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'tearDown::transit::toComplete'] call KPLIB_fnc_missionsSM_onNoOp";
        };
    };

    class KPLIB_missionsSM_state_complete {
        onStateEntered = "[_this, 'KPLIB_fnc_mission_onCompleteEntered'] call KPLIB_fnc_missionsSM_onCompleteEntered";
    };
};
