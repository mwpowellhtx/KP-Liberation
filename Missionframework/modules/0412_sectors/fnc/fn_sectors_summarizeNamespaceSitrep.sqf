#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_summarizeNamespaceSitrep

    File: fn_sectors_summarizeNamespaceSitrep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 12:47:17
    Last Update: 2021-04-23 12:47:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Summarizes the CBA SECTOR namespaces at an overall state machine level. This is useful
        when determining when and whether to trigger secondary missions or objectives around
        the map, pertaining to the engaged area, or in general.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

// There should already be a CBA SECTOR state machine running but allow for null
private _objSM = missionNamespace getVariable [QMVARSM(_objSM), locationNull];

if (isNull _objSM) exitWith {
    false;
};

// Now make key summarization of the REFRESHED SECTORS
private _algoMergeStatus = { (_this select [0, 2]) call KPLIB_fnc_namespace_setStatus; };
private _algoMergeBooleanOr = { _this#0 || _this#1; };


[
    MVAR(_namespaces) apply { _x getVariable [QMVAR(_nearestFob), []]; }
    , MVAR(_namespaces) apply { _x getVariable [QMVAR(_nearestBase), ""]; }
    , MVAR(_namespaces) apply { _x getVariable [QMVAR(_nearestTower), ""]; }
] params [
    Q(_allNearestFobs)
    , Q(_allNearestBases)
    , Q(_allNearestTowers)
];

[
    [[], _allNearestFobs] call KPLIB_fnc_linq_aggregate
    , [[], _allNearestBases] call KPLIB_fnc_linq_aggregate
    , [[], _allNearestTowers] call KPLIB_fnc_linq_aggregate
] params [
    Q(_nearestFobs)
    , Q(_nearestBases)
    , Q(_nearestTowers)
];

[
    [
        MSTATUS(_standby)
        , _active apply { _x getVariable [QMVAR(_status), MSTATUS(_standby)]; }
        , { (_this select [0, 2]) call KPLIB_fnc_namespace_setStatus }
    ] call KPLIB_fnc_linq_aggregate
    , { _x getVariable [QMVAR(_towerBlufor), false]; } count _active
    , { _x getVariable [QMVAR(_towerOpfor), false]; } count _active
    , { _x getVariable [QMVAR(_militaryBlufor), false]; } count _active
    , { _x getVariable [QMVAR(_militaryOpfor), false]; } count _active
    , { (_x getVariable [QMVAR(_bluforUnitCountCap), 0]) >= (_x getVariable [QMVAR(_opforUnitCountCap), 0]); } count _active
    , { (_x getVariable [QMVAR(_bluforTankCountCap), 0]) >= (_x getVariable [QMVAR(_opforTankCountCap), 0]); } count _active
    , { (_x getVariable [QMVAR(_opforUnitCountCap), 0]) >= (_x getVariable [QMVAR(_bluforUnitCountCap), 0]); } count _active
    , { (_x getVariable [QMVAR(_opforTankCountCap), 0]) >= (_x getVariable [QMVAR(_bluforTankCountCap), 0]); } count _active
    , { (_x getVariable [QMVAR(_resistanceUnitCountCap), 0]) > 0; } count _active
] params [
    Q(_statusSummary)
    , Q(_towerBluforSectorCount)
    , Q(_towerOpforSectorCount)
    , Q(_militaryBluforSectorCount)
    , Q(_militaryOpforSectorCount)
    , Q(_bluforUnitSectorCountGte)
    , Q(_bluforTankSectorCountGte)
    , Q(_opforUnitSectorCountGte)
    , Q(_opforTankSectorCountGte)
    , Q(_resistanceSectorCount)
];

{ _objSM setVariable _x; } forEach [
    [QMVARSM(_status), _statusSummary]
    , [QMVARSM(_towerBlufor), _towerBluforSectorCount > 0]
    , [QMVARSM(_towerOpfor), _towerOpforSectorCount > 0]
    , [QMVARSM(_militaryBlufor), _militaryBluforSectorCount > 0]
    , [QMVARSM(_militaryOpfor), _militaryOpforSectorCount > 0]
    , [QMVARSM(_bluforUnitsGte), _bluforUnitSectorCountGte > 0]
    , [QMVARSM(_bluforTanksGte), _bluforTankSectorCountGte > 0]
    , [QMVARSM(_opforUnitsGte), _opforUnitSectorCountGte > 0]
    , [QMVARSM(_opforTanksGte), _opforTankSectorCountGte > 0]
    , [QMVARSM(_resistance), _resistanceSectorCount > 0]
];

true;
