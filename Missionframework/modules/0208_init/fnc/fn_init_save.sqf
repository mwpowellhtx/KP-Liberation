/*
    KPLIB_fnc_init_save

    File: fn_init_save.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-03-29
    Last Update: 2021-05-23 14:08:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves the current progress by firing the doSave event. Prior to assembling the save
        data, raises the KPLIB_updatePersistent CBA server side local event, which adds assets
        that may have entered and are in an eligible state, or removes assets that had
        subsequently left an FOB zone, respectively. After all registered handlers for this
        event are processed, it will write the save data to the profile namespace.

    Parameter(s):
        _callerName - optional caller name [STRING, default: ""]

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/saveProfileNamespace
 */

private _debug = KPLIB_param_debug
    || KPLIB_param_savedebug
    || KPLIB_param_init_save_debug
    ;

params [
    ["_callerName", "", [""]]
];

if (_debug) then {
    [format ["[fn_init_save] Entering: [_callerName]: %1"
        , str [_callerName]], "INIT", true] call KPLIB_fnc_common_log;
};

/* Skip the saving process, if the campaign isn't running anymore. Also prohibit saving
 * under certain conditions, i.e. save triggering when 'build' happens naturally during
 * load deserialization.
 */
if (!(KPLIB_campaignRunning || KPLIB_init_saveEnabled)) exitWith { false; };

// Reset the current save data array
KPLIB_save_data = [];

if (_debug) then {
    ["[fn_init_save] Raising save event...", "INIT"] call KPLIB_fnc_common_log;
};

["KPLIB_doSave"] call CBA_fnc_localEvent;

// Write save data array to profile namespace
if (_debug) then {
    ["[fn_init_save] Writing data to profile", "INIT"] call KPLIB_fnc_common_log;
};

profileNamespace setVariable [KPLIB_save_key, KPLIB_save_data];

saveProfileNamespace;

if (_debug) then {
    [format ["[fn_init_save] Fini: [_callerName]: %1"
        , str [_callerName]], "INIT", true] call KPLIB_fnc_common_log;
};

true;
