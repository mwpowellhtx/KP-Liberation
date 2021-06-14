#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSaveData

    File: fn_garrison_onSaveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-06-14 17:12:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module save data event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onSaveData_debug);

if (_debug) then {
    ["[fn_garrison_onSaveData] Saving...", "GARRISON"] call KPLIB_fnc_common_log;
};

// Set module data to save and send it to the global save data array
["garrison",
    [
        // // TODO: TBD: for now disabling, but we will expect an 'array' or something...
        // // TODO: TBD: possibly changing the key depending on the shape, etc...
        // MVAR(_array)
        []
    ]
] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_garrison_onSaveData] Saved", "GARRISON"] call KPLIB_fnc_common_log;
};

true;
