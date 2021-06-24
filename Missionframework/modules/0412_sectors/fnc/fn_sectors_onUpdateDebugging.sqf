#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onUpdateDebugging

    File: fn_sectors_onUpdateDebugging.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-06-08 11:22:15
    Last Update: 2021-06-24 11:59:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        ...

    Parameter(s):
        ...

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

private _players = allPlayers;
private _debugging = [];

// _debugging pushBack QMVAR(_onRefreshBuckets_debug);
// _debugging pushBack QMVAR(_onRefreshProximities_debug);
// _debugging pushBack QMVAR(_getAllObjects_debug);
// _debugging pushBack QMVAR(_getAllUnits_debug);
// _debugging pushBack QMVAR(_getAllVehicles_debug);

// _debugging pushBack Q(KPLIB_namespace_timerHasElapsed_debug);

// _debugging pushBack Q(KPLIB_enemies_onSectorActivating_debug);
// _debugging pushBack Q(KPLIB_garrison_onCatalogBuildings_debug);
// _debugging pushBack Q(KPLIB_garrison_onCatalogRoads_debug);

// _debugging pushBack Q(KPLIB_sectorSM_onNoOp_debug);
// _debugging pushBack Q(KPLIB_sectorSM_onPendingEntered_debug);
// _debugging pushBack Q(KPLIB_sectorSM_onGarrisonEntered_debug);
// _debugging pushBack Q(KPLIB_sectorSM_onPending_debug);

// _debugging pushBack Q(KPLIB_garrison_onSectorRegiment_debug);
// _debugging pushBack Q(KPLIB_garrison_onSectorGarrison_debug);

// _debugging pushBack Q(KPLIB_garrison_onAllocateMines_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateResources_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateOpforUnits_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateOpforGrps_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateOpforLightVehicles_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateOpforHeavyVehicles_debug);
// _debugging pushBack Q(KPLIB_garrison_onAllocateOpforIntel_debug);

// _debugging pushBack Q(KPLIB_garrison_onRegimentOpforAnnum_debug);
// _debugging pushBack Q(KPLIB_garrison_onRegimentOpforPeren_debug);
// _debugging pushBack Q(KPLIB_garrison_onRegimentOpforUnits_debug);
// _debugging pushBack Q(KPLIB_garrison_onRegimentBluforHeavyVehicles_debug);
// _debugging pushBack Q(KPLIB_garrison_onRegimentBluforLightVehicles_debug);
// _debugging pushBack Q(KPLIB_garrison_onRegimentBluforUnits_debug);

// _debugging pushBack Q(KPLIB_garrison_onCreateBluforAssets_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateBluforUnits_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateMines_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateResources_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateOpforAssets_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateOpforIntel_debug);
// _debugging pushBack Q(KPLIB_garrison_onCreateOpforUnits_debug);

// _debugging pushBack Q(KPLIB_sectors_getBucketBundle_debug);
// _debugging pushBack Q(KPLIB_sectors_getSectorSitRep_debug);
// _debugging pushBack Q(KPLIB_sectors_onNotifySitRep_debug);

// _debugging pushBack Q(KPLIB_sectors_canCapture_debug);
// _debugging pushBack Q(KPLIB_sectors_canCaptureEval_debug);
// _debugging pushBack Q(KPLIB_sectorSM_onCapturedEntered_debug);

// _debugging pushBack Q(KPLIB_sectors_onCapturedSetCaptured_debug);
// _debugging pushBack Q(KPLIB_sectors_onCapturedUpdateArrays_debug);
// _debugging pushBack Q(KPLIB_sectors_onCapturedShowNotification_debug);
// _debugging pushBack Q(KPLIB_sectors_onTearDownVars_debug);
// _debugging pushBack Q(KPLIB_sectors_onTearDownObjects_debug);
// _debugging pushBack Q(KPLIB_garrison_onSectorTearDown_debug);

// _debugging pushBack Q(KPLIB_garrison_onBuildingsDestroyed_debug);
// _debugging pushBack Q(KPLIB_enemies_onSectorCaptured_debug);

// _debugging pushBack Q(KPLIB_captives_onSectorCapturedSurrenderUnits_debug);
// _debugging pushBack Q(KPLIB_captives_onSectorCapturedSurrenderVehicles_debug);

// _debugging pushBack Q(KPLIB_captives_onSurrenderUnitOne_debug);
// _debugging pushBack Q(KPLIB_captives_onSurrenderVehicleOne_debug);

// _debugging pushBack Q(KPLIB_sectors_onTransit_debug);

{
    private _sector = _x;
    { _sector setVariable [_x, _sector in MVAR(_allActive)]; } forEach _debugging;
} forEach MVAR(_namespaces);

// TODO: TBD :could refactor in terms of presets or params...
private _delay = 3;

[
    { _this call MFUNC(_onUpdateDebugging); }
    , []
    , _delay
] call CBA_fnc_waitAndExecute;

true;
