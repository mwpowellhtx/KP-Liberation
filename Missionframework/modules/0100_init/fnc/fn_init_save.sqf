/*
    KPLIB_fnc_init_save

    File: fn_init_save.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-03-29
    Last Update: 2021-02-13 17:48:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves the current progress by firing the doSave event. Prior to assembling the save
        data, raises the KPLIB_updatePersistent CBA server side local event, which adds assets
        that may have entered and are in an eligible state, or removes assets that had
        subsequently left an FOB zone, respectively. After all registered handlers for this
        event are processed, it will write the save data to the profile namespace.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]

    References:
        https://community.bistudio.com/wiki/saveProfileNamespace
 */

private _debug = KPLIB_param_debug || KPLIB_param_savedebug;

// Skip the saving process, if the campaign isn't running anymore
if (!KPLIB_campaignRunning) exitWith {
    false;
};

if (_debug) then {
    ["----- Save function started -----", "SAVE", true] call KPLIB_fnc_common_log;
};

//// TODO: TBD: fill in this gap...
//// TODO: TBD: instead of calling approaching save, should refactor to event loop so that "persistence" is just always presentable...
//["KPLIB_updatePersistent"] call CBA_fnc_localEvent;

// Reset the current save data array
KPLIB_save_data = [];

// Fire the saving event
if (_debug) then {
    ["Firing save event...", "SAVE"] call KPLIB_fnc_common_log;
};

["KPLIB_doSave"] call CBA_fnc_localEvent;

// Write save data array to profile namespace
if (_debug) then {
    ["Writing data to profile...", "SAVE"] call KPLIB_fnc_common_log;
};

profileNamespace setVariable [KPLIB_save_key, KPLIB_save_data];

saveProfileNamespace;

if (_debug) then {
    ["----- Save function finished -----", "SAVE", true] call KPLIB_fnc_common_log;
};

true;
