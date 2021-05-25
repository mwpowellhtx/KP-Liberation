/*
    KPLIB_fnc_init_saveData

    File: fn_init_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-05-18 12:54:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Presents module data for the save operation.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = KPLIB_param_savedebug;

if (_debug) then {
    ["[fn_init_saveData] Saving...", "INIT"] call KPLIB_fnc_common_log;
};

// Set module data to save and send it to the global save data array
["init",
    +[
        date // Current date and time
        , KPLIB_sectors_lockedVeh // Locked Vehicles array
        , KPLIB_sectors_blufor // Blufor sectors
    ]
] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_init_saveData] Fini", "INIT"] call KPLIB_fnc_common_log;
};

true;
