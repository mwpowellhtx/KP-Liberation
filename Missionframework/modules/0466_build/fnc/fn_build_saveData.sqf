/*
    KPLIB_fnc_build_saveData

    File: fn_build_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-11-04
    Last Update: 2021-01-27 22:18:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves build module data.

    Parameters:
        NONE

    Returns:
        Data was saved [BOOL]
*/

if (KPLIB_param_savedebug) then {
    ["Build module saving...", "SAVE"] call KPLIB_fnc_common_log;
};

// Set module data to save and send it to the global save data array
[
    "build",
    []
] call KPLIB_fnc_init_setSaveData;

true
