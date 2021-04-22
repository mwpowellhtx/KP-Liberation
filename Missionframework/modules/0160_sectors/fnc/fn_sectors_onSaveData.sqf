#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onSaveData

    File: fn_sectors_onSaveData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 12:40:54
    Last Update: 2021-04-20 12:40:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Serializes the module NAMESPACES vector during save events.

    Parameters:
        NONE

    Returns:
        NONE
 */

private _debug = MPARAM(_onSaveData_debug);

if (_debug) then {
    ["[fn_sectors_onSaveData] Saving...", "sectors"] call KPLIB_fnc_common_log;
};

private _data = MVAR(_namespaces) apply {
    [_x, MVAR(_serializationRegistry)] call KPLIB_fnc_namespace_serialize;
};

// Set module data to save and send it to the global save data array
[
    "sectors"
    , [
        _data           // 0
    ]
] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_sectors_onSaveData] Saved", "sectors"] call KPLIB_fnc_common_log;
};

true;
