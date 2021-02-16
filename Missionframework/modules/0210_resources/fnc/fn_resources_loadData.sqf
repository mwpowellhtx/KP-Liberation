/*
    KPLIB_fnc_resources_loadData

    File: fn_resources_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-02-15 23:20:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to this module from the given save data or initializes needed data for a new campaign.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

// TODO: TBD: refactor to proper 'KPLIP_fnc_resources_debug' function...
private _debug = KPLIB_param_debug;

if (_debug) then {
    ["[fn_resources_loadData] Loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["resources"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_resources_loadData] Data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
    };
    // Nothing to do here
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_resources_loadData] Data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
    };

    private _storageSums = _moduleData#0;

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

    // TODO: TBD: intel? are we tracking alertness? aggression? civilian rep?
    // Apply the intel points
    KPLIB_resources_intel = _moduleData#1;
};

true;
