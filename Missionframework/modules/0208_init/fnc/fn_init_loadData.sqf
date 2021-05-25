/*
    KPLIB_fnc_init_loadData

    File: fn_init_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-05-23 13:20:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads module data.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = KPLIB_param_debug;

// DISABLE SAVE during the LOAD process, in the event any build/restore/vehicle handlers force a save
[false] call KPLIB_fnc_init_enableSave;

if (_debug) then {
    ["[fn_init_loadData] Loading...", "INIT"] call KPLIB_fnc_common_log;
};

private _moduleData = ["init"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_init_loadData] Init module data empty, creating new data...", "INIT"] call KPLIB_fnc_common_log;
    };

    // Set random start date
    setDate [2018, ceil (random 12), ceil (random 28), 8, 0];

    // Connect locked vehicles to military bases
    private _assignedVehicles = [];
    private _assignedBases = [];
    private _nextVehicle = "";
    private _nextBase = "";
    while {((count _assignedVehicles) < (count KPLIB_preset_lockedVehPlF)) && ((count _assignedBases) < (count KPLIB_sectors_military))} do {
        _nextVehicle =  selectRandom (KPLIB_preset_lockedVehPlF - _assignedVehicles);
        _nextBase =  selectRandom (KPLIB_sectors_military - _assignedBases);
        _assignedVehicles pushBack _nextVehicle;
        _assignedBases pushBack _nextBase;
        KPLIB_sectors_lockedVeh pushBack [_nextVehicle, _nextBase];
    };
    publicVariable "KPLIB_sectors_lockedVeh";
} else {

    // TODO: TBD: introduce more error handling...
    _moduleData params [
        ["_date", [], [[]]]
        , ["_lockedVics", [], [[]]]
        , ["_blufor", [], [[]]]
        // TODO: TBD: dropping the FOB tuples in favor of the building+vars
        // , ["_fobs", [], [[]]]
    ];

    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_init_loadData] Applying...", "INIT"] call KPLIB_fnc_common_log;
    };

    // Set saved date and time
    setDate [
        _date#0
        , _date#1
        , _date#2
        , _date#3
        , _date#4
    ];

    // Check for deleted military sectors or deleted classnames in the locked vehicles array
    KPLIB_sectors_lockedVeh = +_lockedVics;
    KPLIB_sectors_lockedVeh = KPLIB_sectors_lockedVeh select {(_x select 0) in KPLIB_preset_lockedVehPlF};
    KPLIB_sectors_lockedVeh = KPLIB_sectors_lockedVeh select {(_x select 1) in KPLIB_sectors_military};

    // Check for additions in the locked vehicles array
    private _lockedVehCount = count KPLIB_sectors_lockedVeh;
    if ((_lockedVehCount < (count KPLIB_sectors_military)) && (_lockedVehCount < (count KPLIB_preset_lockedVehPlF))) then {
        ["Additional military sectors or unlockable vehicles detected and assigned", "INIT::IMPORTANT"] call KPLIB_fnc_common_log;
        private _assignedVehicles = [];
        private _assignedBases = [];
        private _nextVehicle = "";
        private _nextBase = "";

        {
            _assignedVehicles pushBack (_x select 0);
            _assignedBases pushBack (_x select 1);
        } forEach KPLIB_sectors_lockedVeh;

        while {((count _assignedVehicles) < (count KPLIB_preset_lockedVehPlF)) && ((count _assignedBases) < (count KPLIB_sectors_military))} do {
            _nextVehicle =  selectRandom (KPLIB_preset_lockedVehPlF - _assignedVehicles);
            _nextBase =  selectRandom (KPLIB_sectors_military - _assignedBases);
            _assignedVehicles pushBack _nextVehicle;
            _assignedBases pushBack _nextBase;
            KPLIB_sectors_lockedVeh pushBack [_nextVehicle, _nextBase];
        };
    };
    publicVariable "KPLIB_sectors_lockedVeh";

    // TODO: TBD: which we will likely need to run through a similar round of wipe/transformations for sectors/factories as well...
    // TODO: TBD: ditto changing sector owners... do we really need to see this public after all?
    // TODO: TBD: especially now that we effectively target CID(s) with appropriate events, messages, etc...
    // Publish blufor sectors
    KPLIB_sectors_blufor = +_blufor;
    publicVariable "KPLIB_sectors_blufor";
};

if (_debug) then {
    ["[fn_init_loadData] Fini", "INIT"] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_init_enableSave;

true;
