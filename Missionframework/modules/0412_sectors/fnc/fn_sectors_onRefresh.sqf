#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefresh

    File: fn_sectors_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 11:27:01
    Last Update: 2021-06-14 16:51:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH the SECTOR life lines accordingly. We are not making any decisions
        whatsoever concerning the fate of the SECTOR during this function. The only
        thing we are doing now is filling in the life lines so that subsequent heuristic
        functions can do that decision making.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Maginot_Line
        https://en.wikipedia.org/wiki/Line_in_the_sand
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRefresh_debug)
    || (_sector getVariable [QMVAR(_onRefresh_debug), false]);

// TODO: TBD: this is a work in progress, obviously...
if (true) exitWith { true; };

if (isNull _sector) exitWith {
    if (_debug) exitWith {
        ["[fn_sectors_onRefresh] Null", "SECTORS", true] call KPLIB_fnc_common_log;
    };
    false;
};




// TODO: TBD: only refresh what we have to while idle, i.e. activation range blufor+opfor, etc

[
    _sector getVariable [QMVAR(_markerName), ""]
    //, [_sector, MSTATUS(_active), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_markerName)
    //, Q(_active)
];

if (_debug) then {
    [format ["[fn_sectors_onRefresh] Entering: [_markerName, markerText _markerName, _active]: %1"
        , str [_markerName, markerText _markerName, _active]], "SECTORS", true] call KPLIB_fnc_common_log;
};

[
    markerPos _markerName
    , mapGridPosition (markerPos _markerName)
] params [
    Q(_markerPos)
    , Q(_gridref)
];

[
    MPARAM(_actRange)
    , _markerName in MVAR(_opfor)
    , _markerName in MVAR(_blufor)
] params [
    Q(_actRange)
    , Q(_opfor)
    , Q(_blufor)
];

// Get ALL of the units within ACTIVATION RANGE of the SECTOR one time only
private _allUnitsAct = [_markerPos, _actRange, KPLIB_preset_allSides] call KPLIB_fnc_units_getNear;

// By UNIT TRIGGER RANGE, we mean units that would trigger sector activation
[
    // Depends on MARKER POS
    [_sector, _allUnitsAct, KPLIB_preset_sideE] call MFUNC(_getUnitMinRange)
    , [_sector, _allUnitsAct, KPLIB_preset_sideF] call MFUNC(_getUnitMinRange)
] params [
    Q(_opforTriggerMinRange)
    , Q(_bluforTriggerMinRange)
];

private _triggerMinRange = switch (true) do {
    // MPRESET(_defaultUnitRange) when BOTH indicate nothing in range
    case (_opforTriggerMinRange < 0 && _bluforTriggerMinRange < 0): { MPRESET(_defaultUnitRange); };
    // The other when the one not in range
    case (_opforTriggerMinRange < 0): { _bluforTriggerMinRange; };
    case (_bluforTriggerMinRange < 0): { _opforTriggerMinRange; };
    // Or MIN of each other
    default { _opforTriggerMinRange min _bluforTriggerMinRange; };
};

// Fill in these bits first, MARKER POS is critical at first, as are OPFOR+BLUFOR flags
{ _sector setVariable _x; } forEach [
    // Identify SECTOR bits
    [QMVAR(_markerPos), _markerPos]
    , [QMVAR(_gridref), _gridref]
    , [QMVAR(_opfor), _opfor]
    , [QMVAR(_blufor), _blufor]
    // Arrange OPFOR+BLUFOR+UNIT triggering minimum ranges
    , [QMVAR(_triggerMinRange), _triggerMinRange]
    , [QMVAR(_opforTriggerMinRange), _opforTriggerMinRange]
    , [QMVAR(_bluforTriggerMinRange), _bluforTriggerMinRange]
];

if (_debug) then {
    {
        private _variableName = _x;
        private _value = _sector getVariable _variableName;
        [format ["[fn_sectors_onRefresh] Set: [_variableName, _value]: %1"
            , str [_variableName, _value]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach [
        QMVAR(_markerName)
        , QMVAR(_markerPos)
        , QMVAR(_gridref)
        , QMVAR(_opfor)
        , QMVAR(_blufor)
        , QMVAR(_triggerMinRange)
        , QMVAR(_opforTriggerMinRange)
        , QMVAR(_bluforTriggerMinRange)
    ];
};

// === The SECTOR ACTIVATION Maginot Line ========================================================
if (!_active && _triggerMinRange < 0) exitWith { // i.e. "would 'not' activate"
    if (_debug) then {
        [format ["[fn_sectors_onRefresh] Inactive+would not activate: [_markerName, markerText _markerName, count allVariables _sector]: %1"
            , str [_markerName, markerText _markerName, count allVariables _sector]], "SECTORS", true] call KPLIB_fnc_common_log;
    };
    true;
};

private _fobs = missionNamespace getVariable [QMVAR(_fobs), []];

[
    [_markerName, MVAR(_tower)] call MFUNC(_getNearestSector)
    , [_markerName, MVAR(_military)] call MFUNC(_getNearestSector)
    , [_markerName, MVAR(_fobs)] call MFUNC(_getNearestSector)
] params [
    Q(_nearestTower)
    , Q(_nearestBase)
    , Q(_nearestFob)
];

// The only thing we need to know is nearest TOWER/MILITARY alignment
[
    MPARAM(_capRange)
    , _nearestBase in MVAR(_opfor)
    , _nearestBase in MVAR(_blufor)
    , _nearestTower in MVAR(_opfor)
    , _nearestTower in MVAR(_blufor)
] params [
    Q(_capRange)
    , Q(_nearestBaseOpfor)
    , Q(_nearestBaseBlufor)
    , Q(_nearestTowerOpfor)
    , Q(_nearestTowerBlufor)
];

// We like this better, get the unit set once and narrow from there
private _tankClassName = "Tank";

// Then get just those units that are within CAPTURE RANGE
private _allUnitsCap = _allUnitsAct select { (_x distance2D _markerPos) <= _capRange; };
// Identify all units within ACTIVATION and CAPTURE RANGE of the SECTOR

// Fill in the dashboard of raw CBA SECTOR namespace bits here
{ _sector setVariable _x; } forEach [
    // Arrange nearest FOB+BASE+TOWER+OPFOR+BLUFOR bits
    [QMVAR(_nearestFob), _nearestFob]
    , [QMVAR(_nearestBase), _nearestBase]
    , [QMVAR(_nearestBaseOpfor), _nearestBaseOpfor]
    , [QMVAR(_nearestBaseBlufor), _nearestBaseBlufor]
    , [QMVAR(_nearestTower), _nearestTower]
    , [QMVAR(_nearestTowerOpfor), _nearestTowerOpfor]
    , [QMVAR(_nearestTowerBlufor), _nearestTowerBlufor]
    // Arrange OPFOR+UNIT+TANK+ACT+CAP counts
    , [QMVAR(_opforUnitCountAct), [_allUnitsAct, KPLIB_preset_sideE] call MFUNC(_getUnitCount)]
    , [QMVAR(_opforUnitCountCap), [_allUnitsCap, KPLIB_preset_sideE] call MFUNC(_getUnitCount)]
    , [QMVAR(_opforTankCountAct), [_allUnitsAct, KPLIB_preset_sideE, _tankClassName] call MFUNC(_getUnitCount)]
    , [QMVAR(_opforTankCountCap), [_allUnitsCap, KPLIB_preset_sideE, _tankClassName] call MFUNC(_getUnitCount)]
    // Arrange BLUFOR+UNIT+TANK+ACT+CAP counts
    , [QMVAR(_bluforUnitCountAct), [_allUnitsAct, KPLIB_preset_sideF] call MFUNC(_getUnitCount)]
    , [QMVAR(_bluforUnitCountCap), [_allUnitsCap, KPLIB_preset_sideF] call MFUNC(_getUnitCount)]
    , [QMVAR(_bluforTankCountAct), [_allUnitsAct, KPLIB_preset_sideF, _tankClassName] call MFUNC(_getUnitCount)]
    , [QMVAR(_bluforTankCountCap), [_allUnitsCap, KPLIB_preset_sideF, _tankClassName] call MFUNC(_getUnitCount)]
    // Arrange CIVILIAN+RESISTANCE+UNIT+ACT+CAP bits
    , [QMVAR(_civilianUnitCountAct), [_allUnitsAct, KPLIB_preset_sideC] call MFUNC(_getUnitCount)]
    , [QMVAR(_civilianUnitCountCap), [_allUnitsCap, KPLIB_preset_sideC] call MFUNC(_getUnitCount)]
    , [QMVAR(_resistanceUnitCountAct), [_allUnitsAct, KPLIB_preset_sideR] call MFUNC(_getUnitCount)]
    , [QMVAR(_resistanceUnitCountCap), [_allUnitsCap, KPLIB_preset_sideR] call MFUNC(_getUnitCount)]
];

// May flag this one differently than 'debug'
if (_debug) then {
    {
        private _variableName = _x;
        private _value = _sector getVariable _variableName;
        [format ["[fn_sectors_onRefresh] Set: [_variableName, _value]: %1"
            , str [_variableName, _value]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach [
        QMVAR(_nearestFob)
        , QMVAR(_nearestBase)
        , QMVAR(_nearestBaseOpfor)
        , QMVAR(_nearestBaseBlufor)
        , QMVAR(_nearestTower)
        , QMVAR(_nearestTowerOpfor)
        , QMVAR(_nearestTowerBlufor)
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
    [format ["[fn_sectors_onRefresh] Fini: [_markerName, markerText _markerName, count allVariables _sector]: %1"
        , str [_markerName, markerText _markerName, count allVariables _sector]], "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
