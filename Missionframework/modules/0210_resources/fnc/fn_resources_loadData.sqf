#include "script_component.hpp"
/*
    KPLIB_fnc_resources_loadData

    File: fn_resources_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-04-26 12:18:56
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
    ["[fn_resources_loadData] Loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["resources"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_resources_loadData] Initializing data...", "SAVE"] call KPLIB_fnc_common_log;
    };
    MVAR(_intel) = MPARAM(_defaultIntel);
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_resources_loadData] Applying data...", "SAVE"] call KPLIB_fnc_common_log;
    };

    // See saveData event handler for details concerning storage sum obsolete
    _moduleData params [
        [Q(_storageSums), [], [[]]]
        , [Q(_intel), MPARAM(_defaultIntel)]
    ];

    // TODO: TBD: intel? are we tracking alertness? aggression? civilian rep?
    // Apply the intel points
    MVAR(_intel) = _intel;

    // From previously loaded data...
    KPLIB_sectors_fobs select {
        private _fob = _x;
        private _storageContainers = [_fob] call KPLIB_fnc_resources_getFobStorages;
        _storageContainers select { [_x] call KPLIB_fnc_resources_onPopulateStorage; };
        true;
    };

    // Also from previously loaded or discovered data...
    KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor } select {
        private _markerName = _x;
        private _storageContainers = [_x] call KPLIB_fnc_resources_getFactoryStorages;
        _storageContainers select { [_x] call KPLIB_fnc_resources_onPopulateStorage; };
        true;
    };

    // Otherwise start applying the saved data
    if (_debug) then {
        // TODO: TBD: Verify this, and from there, we should be able to identify storage containers and do some resource restoration...
        [format ["[fn_resources_loadData] [KPLIB_sectors_fobs, KPLIB_sectors_blufor]: %1"
            , str [KPLIB_sectors_fobs, KPLIB_sectors_blufor]], "SAVE"] call KPLIB_fnc_common_log;
    };
};

if (_debug) then {
    ["[fn_resources_loadData] Loaded", "SAVE"] call KPLIB_fnc_common_log;
};

true;
