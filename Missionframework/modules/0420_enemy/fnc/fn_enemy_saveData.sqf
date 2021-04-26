#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_saveData

    File: fn_enemy_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-26 11:56:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Bundles module data for saving.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

private _debug = KPLIB_param_savedebug;

if (_debug) then {
    ["[fn_enemy_saveData] Saving...", "SAVE"] call KPLIB_fnc_common_log;
};

["enemy"
    , [
        MVAR(_strength)
        , MVAR(_awareness)
        , MVAR(_civRep)
    ]
] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_enemy_saveData] Saved", "SAVE"] call KPLIB_fnc_common_log;
};

true;
