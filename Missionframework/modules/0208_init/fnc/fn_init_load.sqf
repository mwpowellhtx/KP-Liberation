/*
    KPLIB_fnc_init_load

    File: fn_init_load.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-03-29
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads save data from the profile namespace and fires the doLoad event.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _debug = KPLIB_param_debug;

if (_debug) then {
    ["----- Load function started -----", "SAVE", true] call KPLIB_fnc_common_log;
};

// Load whole save data
KPLIB_save_data = profileNamespace getVariable [KPLIB_save_key, nil];

// Fire load event
if (_debug) then {
    ["Firing load event...", "SAVE"] call KPLIB_fnc_common_log;
};

["KPLIB_doLoad"] call CBA_fnc_localEvent;

// Publish save loaded state
KPLIB_save_loaded = true;
publicVariable "KPLIB_save_loaded";

if (_debug) then {
    [format ["[fn_init_load] Persistence objects: [count KPLIB_persistence_objects, KPLIB_persistence_objects apply {[typeOf _x, netId _x]}]: %1"
        , str [count KPLIB_persistence_objects, KPLIB_persistence_objects apply {[typeOf _x, netId _x]}]], "SAVE"] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["----- Load function finished -----", "SAVE", true] call KPLIB_fnc_common_log;
};

true;
