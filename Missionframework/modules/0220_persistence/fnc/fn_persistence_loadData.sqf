/*
    KPLIB_fnc_persistence_loadData

    File: fn_persistence_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Created: 2019-02-02
    Last Update: 2021-05-23 14:13:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data related to the module.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = KPLIB_param_persistence_loadData_debug
    || ([] call KPLIB_fnc_persistence_debug);

if (_debug) then {
    ["[fn_persistence_loadData] Loading...", "PERSISTENCE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["persistence"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_persistence_loadData] Initializing...", "PERSISTENCE"] call KPLIB_fnc_common_log;
    };
    true;
};

_moduleData params [
    ["_persistentObjects", [], [[]]]
    , ["_persistentUnits", [], [[]]]
];

// Otherwise start applying the saved data
if (_debug) then {
    [format ["[fn_persistence_loadData] Applying: [count _moduleData, count _persistentObjects, count _persistentUnits]: %1"
        , str [count _moduleData, count _persistentObjects, count _persistentUnits]], "PERSISTENCE"] call KPLIB_fnc_common_log;
};

// Load objects
KPLIB_persistence_objects = _persistentObjects apply {
    private _objectDatum = _x;

    _objectDatum params [
        "_serialized"
        , ["_varData", [], [[]]]
    ];

    private _object = _serialized call KPLIB_fnc_persistence_deserializeObject;

    if (_debug) then {
        [format ["[fn_persistence_loadData::object] Persistence vars: [count _varData, _varData]: %1"
            , str [count _varData, _varData]], "PERSISTENCE"] call KPLIB_fnc_common_log;
    };

    {
        private _varDatum = _x;

        if (_debug) then {
            [format ["[fn_persistence_loadData::object::deserializeVars] Persistence vars: [_varDatum]: %1"
                , str [_varDatum]], "PERSISTENCE"] call KPLIB_fnc_common_log;
        };

        [_object, _varDatum] call KPLIB_fnc_persistence_deserializeVars;
    } forEach _varData;

    ["KPLIB_persistence_objectDeserialized", [_object]] call CBA_fnc_globalEvent;

    [_object] call KPLIB_fnc_persistence_makePersistent;

    // Reserving further filtering of the objects for post init phase
    _object;

} select {
    !isNull _x;
};

// Load units
KPLIB_persistence_units = _persistentUnits apply {
    _x params [
        "_serialized"
        , ["_varData", [], [[]]]
    ];

    private _unit = _serialized call KPLIB_fnc_persistence_deserializeUnit;

    if (_debug) then {
        [format ["[fn_persistence_loadData::unit] Persistence vars: [count _varData, _varData]: %1"
            , str [count _varData, _varData]], "PERSISTENCE"] call KPLIB_fnc_common_log;
    };

    {
        private _varDatum = _x;

        if (_debug) then {
            [format ["[fn_persistence_loadData::unit::deserializeVars] Persistence vars: [_varDatum]: %1"
                , str [_varDatum]], "PERSISTENCE"] call KPLIB_fnc_common_log;
        };

        [_unit, _varDatum] call KPLIB_fnc_persistence_deserializeVars;
    } forEach _varData;

    [_unit] call KPLIB_fnc_persistence_makePersistent;

    _unit;

} select {
    !isNull _x;
};

if (_debug) then {
    [format ["[fn_persistence_loadData] Loaded: [count KPLIB_persistence_objects, count KPLIB_persistence_units]: %1"
        , str [count KPLIB_persistence_objects, count KPLIB_persistence_units]], "PERSISTENCE"] call KPLIB_fnc_common_log;
};

true;
