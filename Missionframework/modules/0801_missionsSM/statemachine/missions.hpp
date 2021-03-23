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

// TODO: TBD: closing thoughts tonight:
// we are thinking there are essentially four states:
// 1. setup: does what it says, a constructor of sorts, raises STARTED 'onStateLeaving', always transitions MISSION
// 2. mission: itself, enter/running/leaving, until SUCCESS/FAILURE, always transitions tear down
// 3. aborting: may be raised at any time once at least RUNNING, handles its business, raises ABORTED 'onStateLeaving', always transitions tear down
// 4. tear down: opposite of setup, for the most part, raises COMPLETED
// and that's about it...
// we can help the cause by doing the more mechanical protocol stuff internally
// thereby freeing the mission author to focus on just those moving parts that make the mission what it is
// it would also be helpful to identify common variables for internal bookkeeping purposes, i.e. a KPLIB_missionsSM_assets, let's say
// and monitor for activities such as vehicle seizure, along these lines, crates are also a thing, or can be...
// also need to be consciencious concerning telemetry, which can vary from mission to mission
// and we should also identify and add API we discover that can help to automate things along the way
// i.e. units, groups, elites, vehicles, compositions, etc...

class KPLIB_missionsSM {
    list = "[] call KPLIB_fnc_missionsSM_onGetList";
    skipNull = 1;

    class KPLIB_missionsSM_state_setup {
        onStateEntered = "[_this, 'setup::onStateEntered'] call KPLIB_fnc_missionsSM_onNoOp";
        onState = "[_mission] call KPLIB_fnc_missionsSM_onSetup";
        onStateLeaving = "[_this, 'setup::onStateLeaving'] call KPLIB_fnc_missionsSM_onNoOp";

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
        onStateEntered = "[_this, 'mission::onStateEntered'] call KPLIB_fnc_missionsSM_onNoOp";
        onState = "[_this, 'KPLIB_fnc_mission_onMission', KPLIB_mission_status_successFailureAborting] call KPLIB_fnc_missionsSM_onMission";
        onStateLeaving = "[_this, 'mission::onStateLeaving'] call KPLIB_fnc_missionsSM_onNoOp";

        class KPLIB_missionsSM_transit_toTearDown {
            targetState = "KPLIB_missionsSM_state_tearDown";
            condition = "[_this, KPLIB_mission_status_successFailureAborting] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'mission::transit::toTearDown'] call KPLIB_fnc_missionsSM_onNoOp";
        };
    };

    class KPLIB_missionsSM_state_tearDown {
        onStateEntered = "[_this, 'tearDown::onStateEntered'] call KPLIB_fnc_missionsSM_onNoOp";
        onState = "[_mission, 'KPLIB_fnc_mission_onTearDown', KPLIB_mission_status_completed] call KPLIB_fnc_missionsSM_onTearDown";
        onStateLeaving = "[_this, 'tearDown::onStateLeaving'] call KPLIB_fnc_missionsSM_onNoOp";

        class KPLIB_missionsSM_transit_toComplete {
            targetState = "KPLIB_missionsSM_state_complete";
            condition = "[_this, KPLIB_mission_status_complete] call KPLIB_fnc_mission_checkStatus";
            onTransition = "[_this, 'tearDown::transit::toComplete'] call KPLIB_fnc_missionsSM_onNoOp";
        };
    };

    // Report COMPLETE, TARGET STATUS MASK: COMPLETED is COMPLETED, one way or another, whether SUCCESS, FAILURE, or neither
    class KPLIB_missionsSM_state_complete {
        // COMPLETED only occurs once, but it follows the same pattern
        onStateEntered = "[_this, 'KPLIB_fnc_mission_onCompleteEntered', KPLIB_mission_status_standby] call KPLIB_fnc_missionsSM_onCompleteEntered";
    };
};
