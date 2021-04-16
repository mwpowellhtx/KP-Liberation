#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_saveData

    File: fn_enemy_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-05 21:17:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fetches data which is bound to this module and send it to the global save data array.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

if (KPLIB_param_savedebug) then {["Enemy module saving...", "SAVE"] call KPLIB_fnc_common_log;};

private _moduleData = [];

_moduleData pushBack MVAR(_strength);
_moduleData pushBack MVAR(_awareness);

// // TODO: TBD: ditto see nots during LOAD DATA
// private _state = (diag_activeMissionFSMs select (diag_activeMissionFSMs findIf {(_x select 0) isEqualTo "KPLIB_enemyCommander"})) select 1;
// _moduleData pushBack _state;

// Set module data to save and send it to the global save data array
["enemy", _moduleData] call KPLIB_fnc_init_setSaveData;

true;
