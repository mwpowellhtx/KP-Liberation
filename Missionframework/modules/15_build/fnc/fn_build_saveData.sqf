/*
    KPLIB_fnc_build_saveData

    File: fn_build_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-04
    Last Update: 2019-03-30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Saves build module data.

    Parameter(s):
        NONE

    Returns:
        Data was saved [BOOL]
*/

if (KPLIB_param_debug) then {diag_log "[KP LIBERATION] [SAVE] Build module saving..."};

// Set module data to save and send it to the global save data array
[
    "build",
    []
] call KPLIB_fnc_init_setSaveData;

true
