#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onLoadData

    File: fn_missions_onLoadData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 20:30:01
    Last Update: 2021-03-19 20:30:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads module data during the deserialization phase.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

// if (KPLIB_param_debug) then {
//     ["Mission module loading...", "SAVE"] call KPLIB_fnc_common_log;
// };

// private _moduleData = ["mission"] call KPLIB_fnc_init_getSaveData;

// // Check if there is a new campaign
// if (_moduleData isEqualTo []) then {
//     if (KPLIB_param_debug) then {
//         ["Mission module data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
//     };

// } else {
//     // Otherwise start applying the saved data
//     if (KPLIB_param_debug) then {
//         ["Mission module data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
//     };
//     MVAR("timeCheck", _moduleData select 0);

// };

true;
