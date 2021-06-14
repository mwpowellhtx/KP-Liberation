/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 14:14:12
    Last Update: 2021-06-14 16:59:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class sectors {
    file = "modules\0412_sectors\fnc";

    // Arranges for module preset variables
    class sectors_presets {};

    // Arranges for module CBA settings
    class sectors_settings {};

    // Loads module data on mission load
    class sectors_onLoadData {};

    // Periodically invoked to save module data during mission save
    class sectors_onSaveData {};

    // Initialization phase event handler
    class sectors_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class sectors_onPostInit {
        postInit = 1;
    };

    // Returns a DEACTIVATION TIMER given the TIMEOUT
    class sectors_getDeactivationTimer {};

    //
    class sectors_canActivate {};

    // Evaluates whether a SECTOR CAN be CAPTURED
    class sectors_canCapture {};

    // Evaluates the CAPTURE CONDITION
    class sectors_canCaptureEval {};

    //
    class sectors_shouldGarrison {};

    // Returns a created CBA SECTOR namespace with QMVAR(_markerName) variable
    class sectors_createSector {};

    // Reconciles deserialized SECTOR NAMESPACES with available sector markers
    class sectors_onReconcileSectors {};

    //
    class sectors_getBucketBundle {};

    //
    class sectors_onRefreshSide {};

    //
    class sectors_onRefreshSectors {};

    //
    class sectors_onRefreshBuckets {};

    //
    class sectors_onRefreshProximities {};

    //
    class sectors_onActivating {};

    //
    class sectors_onCapturedSetCaptured {};

    //
    class sectors_onCapturedUpdateArrays {};

    //
    class sectors_onCapturedShowNotification {};

    //
    class sectors_onTearDownObjects {};

    //
    class sectors_onTearDownVars {};

    //
    class sectors_getCapRatio {};

    //
    class sectors_getCurrentMaxAct {};

    //
    class sectors_getFilteredUnits {};

    //
    class sectors_getFilteredVehicles {};

    //
    class sectors_getCivResRatio {};

    // NOTIFY SITREP for each of the PLAYERS whether in proximity of a SECTOR or not
    class sectors_onNotifySitRep {};

    // Returns the CBA SECTOR namespace corresponding to the target MARKER NAME
    class sectors_getNamespace {};

    // Returns the NEAREST SECTOR to the given MARKER NAME and a set of CANDIDATE MARKERS
    class sectors_getNearestSector {};

    // Returns the set of ACTIVE MARKERS
    class sectors_getActiveSectors {};

    //
    class sectors_getAllObjects {};

    //
    class sectors_getAllUnits {};

    //
    class sectors_getAllVehicles {};

    //
    class sectors_getSectorSitRep {};

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

    //
    class sectors_onUpdateMarkers {};

    // Returns the SIDE corresponding with the SECTOR defender
    class sectors_getSide {};

    //
    class sectors_onUpdateDebugging {};
};

class sectorSM {
    file = "modules\0412_sectors\statemachine";

    // Initialization phase event handler
    class sectorSM_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class sectorSM_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class sectorSM_settings {};

    //
    class sectorSM_createSM {};

    //
    class sectorSM_getSectorsList {};

    //
    class sectorSM_onCapturedEntered {};

    //
    class sectorSM_onTransit {};

    //
    class sectorSM_onGameOver {};

    //
    class sectorSM_onGameOverEntered {};

    //
    class sectorSM_onGarrisonEntered {};

    //
    class sectorSM_onNoOp {};

    //
    class sectorSM_onPending {};

    //
    class sectorSM_onPendingEntered {};

    //
    class sectorSM_zeroSitrep {};
};
