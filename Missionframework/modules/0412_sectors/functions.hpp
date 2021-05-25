/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 14:14:12
    Last Update: 2021-05-18 15:06:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class sectors {
    file = "modules\0412_sectors\fnc";

    // Initialization phase event handler
    class sectors_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class sectors_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class sectors_settings {};

    // Returns a created CBA SECTOR namespace with QMVAR(_markerName) variable
    class sectors_createSector {};

    // Loads module data on mission load
    class sectors_onLoadData {};

    // Periodically invoked to save module data during mission save
    class sectors_onSaveData {};

    // Reconciles deserialized SECTOR NAMESPACES with available sector markers
    class sectors_onReconcileSectors {};

    // Returns the CBA SECTOR namespace corresponding to the target MARKER NAME
    class sectors_getNamespace {};

    // Returns the STATUS decomposed into human readable versions of the flags
    class sectors_getStatusReport {};

    // // Returns the ACTIVATING SECTOR NAMESPACES between state machine cycles
    // class sectors_getActivatingNamespaces {};

    // Returns the NEAREST SECTOR to the given MARKER NAME and a set of CANDIDATE MARKERS
    class sectors_getNearestSector {};

    // Returns the set of ACTIVE MARKERS
    class sectors_getActiveSectors {};

    // Returns the set of INACTIVE MARKERS
    class sectors_getInactiveSectors {};

    // Returns the BLUFOR FACTORY sectors
    class sectors_getBluforFactorySectors {};

    // Returns the set of OPFOR MARKERS
    class sectors_getOpforSectors {};

    // Refreshes key aspects of the CBA SECTOR namespace
    class sectors_onRefresh {};

    // Returns the count of units matching side and class name criteria
    class sectors_getUnitCount {};

    // Returns the minimum range to the target CBA SECTOR namespace from among the units
    class sectors_getUnitMinRange {};

    // Returns whether the unit matches the side and class name criteria
    class sectors_whereUnitMatches {};

    // Returns whether the SECTOR may begin the CAPTURING process
    class sectors_getSectorCapturing {};

    // SECTOR CAPTURED event handler
    class sectors_onSectorCaptured {};

    // Returns whether the SECTOR may begin the DEACTIVATING process
    class sectors_getSectorDeactivating {};

    // // Tries to DEACTICATE the known DEACTIVATED CBA SECTOR namespaces
    // class sectors_tryDeactivate {};

    // //
    // class sectors_onNotifyCapture {};

    //
    class sectors_onUpdateMarkers {};

    // // TODO: TBD: reserved for a later sprint...
    // // TODO: TBD: intention is to relay to sector report HUD via client/server events...
    // class sectors_onUpdateMarkers_dispatchSectorHud {};

    // Returns the SIDE corresponding with the SECTOR defender
    class sectors_getSide {};
};

class sectorsSM {
    file = "modules\0412_sectors\statemachine";

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
    class sectorsSM_onIdle {};

    //
    class sectorsSM_onCapturing {};

    //
    class sectorsSM_onCapturedEntered {};

    //
    class sectorsSM_onCloseAirSupportMissionEntered {};

    //
    class sectorsSM_onCombatAirPatrolMissionEntered {};

    //
    class sectorsSM_onCounterAttackMissionTriggered {};

    //
    class sectorsSM_onDeactivating {};

    //
    class sectorsSM_onDeactivatedTransition {};

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
