#include "script_component.hpp"
/*
    KPLIB_fnc_resources_loadData

    File: fn_resources_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-05-19 17:13:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads module data from the saved bundle.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: refactor to proper 'KPLIP_fnc_resources_debug' function...
private _debug = MPARAM(_loadData_debug);

if (_debug) then {
    ["[fn_resources_loadData] Loading...", "RESOURCES"] call KPLIB_fnc_common_log;
};

private _moduleData = ["resources"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_resources_loadData] Initializing...", "RESOURCES"] call KPLIB_fnc_common_log;
    };
    MVAR(_intel) = MPARAM(_defaultIntel);
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_resources_loadData] Applying...", "RESOURCES"] call KPLIB_fnc_common_log;
    };

    // See saveData event handler for details concerning storage sum obsolete
    _moduleData params [
        [Q(_storageSums), [], [[]]]
        , [Q(_intel), MPARAM(_defaultIntel)]
    ];

    // TODO: TBD: intel? are we tracking alertness? aggression? civilian rep?
    // Apply the intel points
    MVAR(_intel) = _intel;

    // Otherwise start applying the saved data
    if (_debug) then {
        [format ["[fn_resources_loadData] [KPLIB_sectors_blufor]: %1"
            , str [KPLIB_sectors_blufor]], "RESOURCES"] call KPLIB_fnc_common_log;
    };
};

if (_debug) then {
    ["[fn_resources_loadData] Loaded", "RESOURCES"] call KPLIB_fnc_common_log;
};

true;
