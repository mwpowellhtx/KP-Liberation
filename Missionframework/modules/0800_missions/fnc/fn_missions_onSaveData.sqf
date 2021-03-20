#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onSaveData

    File: fn_missions_onSaveData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:42:23
    Last Update: 2021-03-19 17:42:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves data approaching the serialization phase.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

// if (KPLIB_param_savedebug) then {
//     ["Mission module saving...", "SAVE"] call KPLIB_fnc_common_log;
// };

// // TODO: TBD: so... if there is "time" comprehension, then maybe we bundle some timer bits with each mission, do they "save" between restarts, etc?
// // Modify the data which will be saved
// private _timeData = (MGVAR("timeCheck", [])) apply {[_x select 0, (_x select 1) - diag_tickTime]};

// // Set module data to save and send it to the global save data array
// ["mission",
//     [
//         _timeData
//     ]
// ] call KPLIB_fnc_init_setSaveData;

true;
