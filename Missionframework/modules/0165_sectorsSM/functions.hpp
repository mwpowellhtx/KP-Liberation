/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 14:14:12
    Last Update: 2021-04-13 22:57:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class sectorsSM {
    file = "modules\0165_sectorsSM\fnc";

    // Initialization phase event handler
    class sectorsSM_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class sectorsSM_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class sectorsSM_settings {};

    //
    class sectorsSM_createSM {};

    //
    class sectorsSM_getSectorsList {};

    //
    class sectorsSM_getStochasticTrigger {};

    //
    class sectorsSM_onAntiAirMissionEntered {};

    //
    class sectorsSM_onCapturingEntered {};

    //
    class sectorsSM_onCloseAirSupportMissionEntered {};

    //
    class sectorsSM_onCombatAirPatrolMissionEntered {};

    //
    class sectorsSM_onCounterAttackMissionTransit {};

    //
    class sectorsSM_onDeactivatingEntered {};

    //
    class sectorsSM_onGameOver {};

    //
    class sectorsSM_onGameOverEntered {};

    //
    class sectorsSM_onGarrison {};

    //
    class sectorsSM_onGarrisonEntered {};

    //
    class sectorsSM_onNoOp {};

    //
    class sectorsSM_onPatrolMissionEntered {};

    //
    class sectorsSM_onPending {};

    //
    class sectorsSM_onPendingEntered {};

    //
    class sectorsSM_onReinforce {};

    //
    class sectorsSM_onReinforceEntered {};

    //
    class sectorsSM_onResistance {};

    //
    class sectorsSM_onResistanceEntered {};

    //
    class sectorsSM_timerHasElapsed {};

    //
    class sectorsSM_zeroSitrep {};
};
