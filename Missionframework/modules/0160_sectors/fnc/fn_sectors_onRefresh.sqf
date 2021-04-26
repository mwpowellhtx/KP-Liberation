#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefresh

    File: fn_sectors_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 11:27:01
    Last Update: 2021-04-24 13:44:26
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

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRefresh_debug)
    || (_namespace getVariable [QMVAR(_onRefresh_debug), false]);

if (isNull _namespace) exitWith {
    if (_debug) exitWith {
        ["[fn_sectors_onRefresh] Null", "SECTORS", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];
private _markerPos = markerPos _markerName;
private _gridref = mapGridPosition _markerPos;

if (_debug) then {
    [format ["[fn_sectors_onRefresh] Entering: [_markerName, _markerPos, markerText _markerName]: %1"
        , str [_markerName, _markerPos, markerText _markerName]], "SECTORS", true] call KPLIB_fnc_common_log;
};

[] call MFUNC(_getOpforSectors);

private _fobs = missionNamespace getVariable [QMVAR(_fobs), []];

[
    MPARAM(_actRange)
    , MPARAM(_capRange)
    , _markerName in MVAR(_opfor)
    , _markerName in MVAR(_blufor)
    , [_markerName, MVAR(_tower)] call MFUNC(_getNearestSector)
    , [_markerName, MVAR(_military)] call MFUNC(_getNearestSector)
    , [_markerName, _fobs apply { (_x#0); }] call MFUNC(_getNearestSector)
] params [
    Q(_actRange)
    , Q(_capRange)
    , Q(_opfor)
    , Q(_blufor)
    , Q(_nearestTower)
    , Q(_nearestBase)
    , Q(_nearestFob)
];

// The only thing we need to know is nearest TOWER/MILITARY alignment
[
    _nearestBase in MVAR(_opfor)
    , _nearestBase in MVAR(_blufor)
    , _nearestTower in MVAR(_opfor)
    , _nearestTower in MVAR(_blufor)
] params [
    Q(_nearestBaseOpfor)
    , Q(_nearestBaseBlufor)
    , Q(_nearestTowerOpfor)
    , Q(_nearestTowerBlufor)
];

// We like this better, get the unit set once and narrow from there
private _tankClassName = "Tank";
private _manClassName = "CAManBase";

// Get ALL of the units within ACTIVATION RANGE of the SECTOR one time only
private _allUnitsAct = [_markerPos, _actRange, KPLIB_preset_sides] call KPLIB_fnc_units_getNear;
// Then get just those units that are within CAPTURE RANGE
private _allUnitsCap = _allUnitsAct select { (_x distance2D _markerPos) <= _capRange; };
// Identify all units within ACTIVATION and CAPTURE RANGE of the SECTOR

// 'Friendly' is the default SIDE, and 'Man' is the default class name
private _getUnitCount = {
    params [
        [Q(_units), _allUnitsAct, [[]]]
        , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
        , [Q(_className), _manClassName, [""]]
    ];
    {
        side _x isEqualTo _side
            && _x isKindOf _className;
    } count _units;
};

private _getMinRange = {
    params [
        [Q(_units), _allUnitsAct, [[]]]
        , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
        , [Q(_className), _manClassName, [""]]
    ];
    private _selected = _units select {
        side _x isEqualTo _side
            && _x isKindOf _className;
    };
    if (count _selected == 0) then { -1; } else {
        private _ranges = _selected apply { _x distance2D _markerPos; };
        selectMin _ranges;
    };
};

// By UNIT TRIGGER RANGE, we mean units that would trigger sector activation
[
    [_allUnitsAct, KPLIB_preset_sideE] call _getMinRange
    , [_allUnitsAct, KPLIB_preset_sideF] call _getMinRange
] params [
    Q(_opforTriggerMinRange)
    , Q(_bluforTriggerMinRange)
];

private _triggerMinRange = switch (true) do {
    // -1 when BOTH indicate nothing in range (i.e. -1)
    case (_opforTriggerMinRange < 0 && _bluforTriggerMinRange < 0): { -1; };
    // Either of them nothing in range (-1)
    case (_opforTriggerMinRange < 0): { _bluforTriggerMinRange; };
    case (_bluforTriggerMinRange < 0): { _opforTriggerMinRange; };
    // Or MIN of each other
    default { _opforTriggerMinRange min _bluforTriggerMinRange; };
};

// Fill in the dashboard of raw CBA SECTOR namespace bits here
{ _namespace setVariable _x; } forEach [
    // Identify SECTOR bits
    [QMVAR(_markerPos), _markerPos]
    , [QMVAR(_gridref), _gridref]
    , [QMVAR(_opfor), _opfor]
    , [QMVAR(_blufor), _blufor]
    // Arrange nearest FOB+BASE+TOWER+OPFOR+BLUFOR bits
    , [QMVAR(_nearestFob), _nearestFob]
    , [QMVAR(_nearestBase), _nearestBase]
    , [QMVAR(_nearestBaseOpfor), _nearestBaseOpfor]
    , [QMVAR(_nearestBaseBlufor), _nearestBaseBlufor]
    , [QMVAR(_nearestTower), _nearestTower]
    , [QMVAR(_nearestTowerOpfor), _nearestTowerOpfor]
    , [QMVAR(_nearestTowerBlufor), _nearestTowerBlufor]
    // Arrange OPFOR+BLUFOR+UNIT triggering minimum ranges, default: -1
    , [QMVAR(_triggerMinRange), _triggerMinRange]
    , [QMVAR(_opforTriggerMinRange), _opforTriggerMinRange]
    , [QMVAR(_bluforTriggerMinRange), _bluforTriggerMinRange]
    // Arrange OPFOR+UNIT+TANK+ACT+CAP counts
    , [QMVAR(_opforUnitCountAct), [_allUnitsAct, KPLIB_preset_sideE, _manClassName] call _getUnitCount]
    , [QMVAR(_opforUnitCountCap), [_allUnitsCap, KPLIB_preset_sideE, _manClassName] call _getUnitCount]
    , [QMVAR(_opforTankCountAct), [_allUnitsAct, KPLIB_preset_sideE, _tankClassName] call _getUnitCount]
    , [QMVAR(_opforTankCountCap), [_allUnitsCap, KPLIB_preset_sideE, _tankClassName] call _getUnitCount]
    // Arrange BLUFOR+UNIT+TANK+ACT+CAP counts
    , [QMVAR(_bluforUnitCountAct), [_allUnitsAct, KPLIB_preset_sideF, _manClassName] call _getUnitCount]
    , [QMVAR(_bluforUnitCountCap), [_allUnitsCap, KPLIB_preset_sideF, _manClassName] call _getUnitCount]
    , [QMVAR(_bluforTankCountAct), [_allUnitsAct, KPLIB_preset_sideF, _tankClassName] call _getUnitCount]
    , [QMVAR(_bluforTankCountCap), [_allUnitsCap, KPLIB_preset_sideF, _tankClassName] call _getUnitCount]
    // Arrange CIVILIAN+RESISTANCE+UNIT+ACT+CAP bits
    , [QMVAR(_civilianUnitCountAct), [_allUnitsAct, KPLIB_preset_sideC, _manClassName] call _getUnitCount]
    , [QMVAR(_civilianUnitCountCap), [_allUnitsCap, KPLIB_preset_sideC, _manClassName] call _getUnitCount]
    , [QMVAR(_resistanceUnitCountAct), [_allUnitsAct, KPLIB_preset_sideR, _manClassName] call _getUnitCount]
    , [QMVAR(_resistanceUnitCountCap), [_allUnitsCap, KPLIB_preset_sideR, _manClassName] call _getUnitCount]
];

// May flag this one differently than 'debug'
if (_debug) then {
    {
        private _variableName = _x;
        private _value = _namespace getVariable _variableName;
        [format ["[fn_sectors_onRefresh] Set: [_variableName, _value]: %1"
            , str [_variableName, _value]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach [
        QMVAR(_markerName)
        , QMVAR(_markerPos)
        , QMVAR(_gridref)
        , QMVAR(_opfor)
        , QMVAR(_blufor)
        , QMVAR(_nearestFob)
        , QMVAR(_nearestBase)
        , QMVAR(_nearestBaseOpfor)
        , QMVAR(_nearestBaseBlufor)
        , QMVAR(_nearestTower)
        , QMVAR(_nearestTowerOpfor)
        , QMVAR(_nearestTowerBlufor)
        , QMVAR(_triggerMinRange)
        , QMVAR(_opforTriggerMinRange)
        , QMVAR(_bluforTriggerMinRange)
        , QMVAR(_opforUnitCountAct)
        , QMVAR(_opforUnitCountCap)
        , QMVAR(_opforTankCountAct)
        , QMVAR(_opforTankCountCap)
        , QMVAR(_bluforUnitCountAct)
        , QMVAR(_bluforUnitCountCap)
        , QMVAR(_bluforTankCountAct)
        , QMVAR(_bluforTankCountCap)
        , QMVAR(_civilianUnitCountAct)
        , QMVAR(_civilianUnitCountCap)
        , QMVAR(_resistanceUnitCountAct)
        , QMVAR(_resistanceUnitCountCap)
    ];
};

if (_debug) then {
    [format ["[fn_sectors_onRefresh] Fini: [_markerName, markerText _markerName, count allVariables _namespace]: %1"
        , str [_markerName, markerText _markerName, count allVariables _namespace]], "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
