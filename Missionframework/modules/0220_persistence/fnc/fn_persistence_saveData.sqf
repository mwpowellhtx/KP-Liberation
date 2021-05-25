/*
    KPLIB_fnc_persistence_saveData

    File: fn_persistence_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-02-02
    Last Update: 2021-05-23 13:10:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves data related to the module.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = KPLIB_param_persistence_saveData_debug
    || ([] call KPLIB_fnc_persistence_debug);

if (_debug) then {
    ["[fn_persistence_saveData] Saving...", "PERSISTENCE"] call KPLIB_fnc_common_log;
};

// Allowing for OBJECTS+UNITS watch callbacks to do the work
[
    missionNamespace getVariable ["KPLIB_persistence_objects", []]
    , missionNamespace getVariable ["KPLIB_persistence_units", []]
] params [
    "_objects"
    , "_units"
];

if (_debug) then {
    [format ["[fn_persistence_saveData] Persistence objects: [count _objects, count _units]: %1"
        , str [count _objects, count _units]], "PERSISTENCE"] call KPLIB_fnc_common_log;
};

// Raise some events preceding the actual serialization phase
{ ["KPLIB_persistence_serializingObject", [_x]] call CBA_fnc_globalEvent; } forEach KPLIB_persistence_objects;

// Set module data to save and send it to the global save data array
["persistence", [
    KPLIB_persistence_objects apply {
        [
            _x call KPLIB_fnc_persistence_serializeObject
            , _x call KPLIB_fnc_persistence_serializeVars
        ]
    }
    , KPLIB_persistence_units apply {
        [
            _x call KPLIB_fnc_persistence_serializeUnit
            , _x call KPLIB_fnc_persistence_serializeVars
        ]
    }
]] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_persistence_saveData] Saved", "PERSISTENCE"] call KPLIB_fnc_common_log;
};

true;
