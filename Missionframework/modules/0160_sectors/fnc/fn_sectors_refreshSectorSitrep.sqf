#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_refreshSectorSitrep

    File: fn_sectors_refreshSectorSitrep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:53:02
    Last Update: 2021-04-22 14:56:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH the SECTOR life lines accordingly. We are not making any decisions
        whatsoever concerning the fate of the SECTOR during this function. The only
        thing we are doing now is filling in the life lines so that subsequent heuristic
        functions can do that decision making.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

private _debug = MPARAM(_refreshSectorSitrep_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

if (isNull _namespace) exitWith {
    if (_debug) exitWith {
        ["[fn_sectors_refreshSectorSitrep] Null", "SECTORS", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

// So as not to miss this later on amid the noise
[
    markerPos _markerName
    , [_markerName] call MFUNC(_getSectorIcon)
] params [
    Q(_markerPos)
    , Q(_sectorIcon)
];

if (_debug) then {
    [format ["[fn_sectors_refreshSectorSitrep] Entering: [_markerName, _markerPos, markerText _markerName]"
        , str [_markerName, _markerPos, markerText _markerName]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: assumes that we have at least 1 (really 2 for sort to be worthwhile) sectors...
[
    MPARAM(_actRange)
    , MPARAM(_capRange)
    , _markerName in MVAR(_opfor)
    , _markerName in MVAR(_blufor)
    , [_markerName, MVAR(_fobs) apply { (_x#0); }] call MFUNC(_getNearestSector)
    , [_markerName, MVAR(_military)] call MFUNC(_getNearestSector)
    , [_markerName, MVAR(_tower)] call MFUNC(_getNearestSector)
] params [
    Q(_actRange)
    , Q(_capRange)
    , Q(_opfor)
    , Q(_blufor)
    , Q(_nearestFob)
    , Q(_nearestBase)
    , Q(_nearestTower)
];

// The only thing we need to know is nearest TOWER/MILITARY alignment
[
    _nearestBase in MVAR(_opfor)
    , _nearestBase in MVAR(_blufor)
    , _nearestTower in MVAR(_opfor)
    , _nearestTower in MVAR(_blufor)
] params [
    Q(_baseOpfor)
    , Q(_baseBlufor)
    , Q(_towerOpfor)
    , Q(_towerBlufor)
];

// Identify all units within ACTIVATION and CAPTURE RANGE of the SECTOR
[
    [_markerPos, _actRange, [KPLIB_preset_sideE]] call KPLIB_fnc_units_getNear
    , [_markerPos, _actRange, [KPLIB_preset_sideF]] call KPLIB_fnc_units_getNear
    , [_markerPos, _actRange, [KPLIB_preset_sideC]] call KPLIB_fnc_units_getNear
    , [_markerPos, _actRange, [KPLIB_preset_sideR]] call KPLIB_fnc_units_getNear
    , [_markerPos, _capRange, [KPLIB_preset_sideE]] call KPLIB_fnc_units_getNear
    , [_markerPos, _capRange, [KPLIB_preset_sideF]] call KPLIB_fnc_units_getNear
    , [_markerPos, _capRange, [KPLIB_preset_sideC]] call KPLIB_fnc_units_getNear
    , [_markerPos, _capRange, [KPLIB_preset_sideR]] call KPLIB_fnc_units_getNear
] params [
    Q(_opforNearAct)
    , Q(_bluforNearAct)
    , Q(_civilianNearAct)
    , Q(_resistanceNearAct)
    , Q(_opforNearCap)
    , Q(_bluforNearCap)
    , Q(_civilianNearCap)
    , Q(_resistanceNearCap)
];

private _whereNearTank = { _x isKindOf "Tank"; };
private _whereNearKindOfMan = { _x isKindOf "CAManBase"; };

// Fill in the dashboard of raw CBA SECTOR namespace bits here
{ _namespace setVariable _x; } forEach [
    [QMVAR(_markerPos), _markerPos]
    , [QMVAR(_sectorIcon), _sectorIcon]
    , [QMVAR(_nearestFob), _nearestFob]
    , [QMVAR(_nearestBase), _nearestBase]
    , [QMVAR(_nearestTower), _nearestTower]
    , [QMVAR(_opfor), _opfor]
    , [QMVAR(_blufor), _blufor]
    , [QMVAR(_baseOpfor), _baseOpfor]
    , [QMVAR(_towerOpfor), _towerOpfor]
    , [QMVAR(_baseBlufor), _baseBlufor]
    , [QMVAR(_towerBlufor), _towerBlufor]
    , [QMVAR(_opforUnitCountAct), _whereNearKindOfMan count _opforNearAct]
    , [QMVAR(_opforUnitCountCap), _whereNearKindOfMan count _opforNearCap]
    , [QMVAR(_opforTankCountAct), _whereNearTank count _opforNearAct]
    , [QMVAR(_opforTankCountCap), _whereNearTank count _opforNearCap]
    , [QMVAR(_bluforUnitCountAct), _whereNearKindOfMan count _bluforNearAct]
    , [QMVAR(_bluforUnitCountCap), _whereNearKindOfMan count _bluforNearCap]
    , [QMVAR(_bluforTankCountAct), _whereNearTank count _bluforNearAct]
    , [QMVAR(_bluforTankCountCap), _whereNearTank count _bluforNearCap]
    , [QMVAR(_civilianUnitCountAct), _whereNearKindOfMan count _civilianNearAct]
    , [QMVAR(_civilianUnitCountCap), _whereNearKindOfMan count _civilianNearCap]
    , [QMVAR(_resistanceUnitCountAct), _whereNearKindOfMan count _resistanceNearAct]
    , [QMVAR(_resistanceUnitCountCap), _whereNearKindOfMan count _resistanceNearCap]
];

if (_debug) then {
    [format ["[fn_sectors_refreshSectorSitrep] Fini: [count allVariables _namespace, allVariables _namespace]: %1"
        , str [count allVariables _namespace, allVariables _namespace]], "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
