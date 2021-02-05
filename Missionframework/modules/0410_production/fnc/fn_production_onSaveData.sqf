/*
    KPLIB_fnc_production_onSaveData

    File: fn_production_onSaveData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:58:58
    Last Update: 2021-02-04 13:59:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fetches data which is bound to this module and send it to the global save data array.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _debug = [[KPLIB_param_savedebug]] call KPLIB_fnc_production_debug;

if (_debug) then {
    ["[fn_production_onSaveData] Setting save data...", "PRODUCTION"] call KPLIB_fnc_common_log;
};

// Set module data to save and send it to the global save data array
[
    // TODO: TBD: we may probe the FSMs that may be running, so on and so forth...
    KPLIB_production_moduleData_key
    , +[
        KPLIB_production
    ]
] call KPLIB_fnc_init_setSaveData;

true
