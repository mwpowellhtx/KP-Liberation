#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_getSectorsList

    File: fn_sectorsSM_getSectorsList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-13 13:43:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the next set of CBA SECTOR namespaces approaching a next round
        of CBA statemachine processing.

    Parameter(s):
        NONE

    Returns:
        An ARRAY containing the active CBA SECTOR namespaces [ARRAY]
 */

private _debug = MPARAMSM(_onGetContextList_debug);

if (!KPLIB_campaignRunning) exitWith {
    [];
};

// There should already be a CBA SECTOR state machine running but allow for null
private _objSM = missionNamespace getVariable [QMVARSM(_objSM), locationNull];

// TODO: TBD: actually, the question needs to be broader than that...
// TODO: TBD: counts for both OPFOR as well as BLUFOR, for reasons:
// TODO: TBD: i.e. sector BLUFOR, CIVREP sufficiently negative, may spawn IEDs, insurgents, etc
// TODO: TBD: i.e. there may be OPFOR nearby, sector may be garrisoned, defended, etc
// TODO: TBD: i.e.
// TODO: TBD: i.e.
// TODO: TBD: i.e.

// Refresh the OPFOR SECTORS, will be useful during the SECTOR REFRESH
[] call MFUNC(_getOpforSectors);

// GC the ACTIVE SECTORS that may be
private _sectors = MVARSM(_sectors) select { !([_x] call MFUNC(_tryGC)); };

if (_debug) then {
    [format ["[fn_sectorsSM_getSectorsList] GC Sectors: [count MVARSM(_sectors), count _sectors]: %1"
        , str [count MVARSM(_sectors), count _sectors]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _activatingSectors = [] call MFUNC(_getActivatingSectors);

private _sectorsToAppend = _activatingSectors apply { [_x] call MFUNC(_createSector); };

_sectors append _sectorsToAppend;

// TODO: TBD: may zero the state machine sitrep beforehand...
[_objSM] call MFUNCSM(_zeroSitrep);

{ [_x, _objSM] call MFUNC(_refreshSectorSitrep); } forEach _sectors;

// Now make key summarization of the REFRESHED SECTORS
private _algoMergeStatus = { [_this#0, _this#1] call KPLIB_fnc_namespace_setStatus; };
private _algoMergeBooleanOr = { _this#0 || _this#1; };

[
    [
        MSTATUS(_standby)
        , _sectors apply { _x getVariable [QMVAR(_status), MSTATUS(_standby)]; }
        , { params [Q(_a), Q(_b)]; [_a, _b] call KPLIB_fnc_namespace_setStatus }
    ] call KPLIB_fnc_linq_aggregate
    , { _x getVariable [QMVAR(_towerBlufor), false]; } count _sectors
    , { _x getVariable [QMVAR(_towerOpfor), false]; } count _sectors
    , { _x getVariable [QMVAR(_militaryBlufor), false]; } count _sectors
    , { _x getVariable [QMVAR(_militaryOpfor), false]; } count _sectors
    , { (_x getVariable [QMVAR(_bluforUnitCountCap), 0]) >= (_x getVariable [QMVAR(_opforUnitCountCap), 0]); } count _sectors
    , { (_x getVariable [QMVAR(_bluforTankCountCap), 0]) >= (_x getVariable [QMVAR(_opforTankCountCap), 0]); } count _sectors
    , { (_x getVariable [QMVAR(_opforUnitCountCap), 0]) >= (_x getVariable [QMVAR(_bluforUnitCountCap), 0]); } count _sectors
    , { (_x getVariable [QMVAR(_opforTankCountCap), 0]) >= (_x getVariable [QMVAR(_bluforTankCountCap), 0]); } count _sectors
    , { (_x getVariable [QMVAR(_resistanceUnitCountCap), 0]) > 0; } count _sectors
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

// TODO: TBD: we may also determine which sector(s) will call for which missions...

MVARSM(_sectors) = _sectors;

MVAR(_active) = MVARSM(_sectors) apply { _x getVariable [QMVAR(_markerName), ""]; };

// Then UPDATE MARKERS once we have identified ACTIVE SECTORS
[Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;

// For use with the CBA state machine
_sectors;
