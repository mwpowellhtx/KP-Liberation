/*
    KPLIB_fnc_persistence_loadData

    File: fn_persistence_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Created: 2019-02-02
    Last Update: 2021-02-14 12:07:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to persistence module from the given save data or initializes needed data for a new campaign.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

if (_debug) then {
    ["[fn_persistence_loadData] Loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["persistence"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_persistence_loadData] Data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
    };
    true;
};

// Otherwise start applying the saved data
if (_debug) then {
    ["[fn_persistence_loadData] Data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
};

// // Leaving this in for the time being; it was a BEAR if anything broke during serialization to reset things.
// KPLIB_persistence_objects = [];

// Load objects
KPLIB_persistence_objects = (_moduleData#0) apply {
    private _objectDatum = _x;

    _objectDatum params [
        "_serialized"
        , ["_varData", [], [[]]]
    ];

    private _object = _serialized call KPLIB_fnc_persistence_deserializeObject;

    if (_debug) then {
        [format ["[fn_persistence_loadData::object] Persistence vars: [count _varData, _varData]: %1"
            , str [count _varData, _varData]], "SAVE"] call KPLIB_fnc_common_log;
    };

    {
        private _varDatum = _x;

        if (_debug) then {
            [format ["[fn_persistence_loadData::object::deserializeVars] Persistence vars: [_varDatum]: %1"
                , str [_varDatum]], "SAVE"] call KPLIB_fnc_common_log;
        };

        [_object, _varDatum] call KPLIB_fnc_persistence_deserializeVars;
    } forEach _varData;

    // Reserving further filtering of the objects for post init phase
    _object;

} select {
    !isNull _x;
};

if (_debug) then {
    [format ["[fn_persistence_loadData] Persistence objects: [count _objects, typeOfs]: %1"
        , str [count KPLIB_persistence_objects, KPLIB_persistence_objects apply { typeOf _x; }]], "SAVE"] call KPLIB_fnc_common_log;
};

// Load units
KPLIB_persistence_units = (_moduleData#1) apply {
    _x params [
        "_serialized"
        , ["_varData", [], [[]]]
    ];

    private _unit = _serialized call KPLIB_fnc_persistence_deserializeUnit;

    if (_debug) then {
        [format ["[fn_persistence_loadData::unit] Persistence vars: [count _varData, _varData]: %1"
            , str [count _varData, _varData]], "SAVE"] call KPLIB_fnc_common_log;
    };

    {
        private _varDatum = _x;

        if (_debug) then {
            [format ["[fn_persistence_loadData::unit::deserializeVars] Persistence vars: [_varDatum]: %1"
                , str [_varDatum]], "SAVE"] call KPLIB_fnc_common_log;
        };

        [_unit, _varDatum] call KPLIB_fnc_persistence_deserializeVars;
    } forEach _varData;

    _unit;

} select {
    !isNull _x;
};

true;
