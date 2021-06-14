#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onLoadData

    File: fn_garrison_onLoadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-06-14 17:12:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module load data event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onLoadData_debug);

if (_debug) then {
    ["[fn_garrison_onLoadData] Loading...", "GARRISON"] call KPLIB_fnc_common_log;
};

private _moduleData = ["garrison"] call KPLIB_fnc_init_getSaveData;

// TODO: TBD: this was for the 'blufor garrisons' but we are going to change how that all works in the not too distant future...
MVAR(_array) = [];

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {

    if (_debug) then {
        ["[fn_garrison_onLoadData] Initializing...", "GARRISON"] call KPLIB_fnc_common_log;
    };

    // // // TODO: TBD: for now disabling "garrison" serialization...
    // // Initialize every sector and add the data to the garrison array
    //{
    //    MVAR(_array) pushBack ([_x] call MFUNC(_initSector));
    //} forEach KPLIB_sectors_all;

} else {

    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_garrison_onLoadData] Applying...", "GARRISON"] call KPLIB_fnc_common_log;
    };

    // // TODO: TBD: for now disabling "garrison" serialization...
    // _moduleData params [
    //     [Q(_array), [], [[]]]
    // ];
    // {
    //     _x params [
    //         [Q(_markerName), "", [""]]
    //     ];
    // } forEach _array;
    // MVAR(_array) append _array;
};

// // TODO: TBD: ditto 'public' vars...
// publicVariable QMVAR(_array);

true;
