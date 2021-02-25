/*
    KPLIB_fnc_logistics_onSaveData

    File: fn_logistics_onSaveData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

private _debug = [] call KPLIB_fnc_logistics_debug;

if (_debug) then {
    ["[fn_logistics_onSaveData] Saving data...", "LOGISTICS"] call KPLIB_fnc_common_log;
};

// Set module data to save and send it to the global save data array
[
    "logistics"
    , [
        KPLIB_logistics_namespaces apply { [_x] call KPLIB_fnc_logistics_namespaceToArray; }
    ]
] call KPLIB_fnc_init_setSaveData;

true;
