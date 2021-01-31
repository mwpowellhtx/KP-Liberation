/*
    KPLIB_fnc_init_saveData

    File: fn_init_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-01-26 17:04:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fetches data which is bound to the init module and send it to the global save data array.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (KPLIB_param_savedebug) then {
    ["Init module saving...", "SAVE"] call KPLIB_fnc_common_log;
};

// TODO: TBD: so... "all" sectors land in "blufor" sectors?
// Set module data to save and send it to the global save data array
["init",
    [
        date // Current date and time
        , KPLIB_sectors_lockedVeh // Locked Vehicles array
        , KPLIB_sectors_blufor // Blufor sectors
        , KPLIB_sectors_fobs // FOB array of FOB tuples
    ]
] call KPLIB_fnc_init_setSaveData;

true
