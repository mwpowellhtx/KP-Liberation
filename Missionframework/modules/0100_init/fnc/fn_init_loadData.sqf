/*
    KPLIB_fnc_init_loadData

    File: fn_init_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-01-26 17:07:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to the init module from the given save data or initializes needed data for a new campaign.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (KPLIB_param_debug) then {
    ["Init module loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["init"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (KPLIB_param_debug) then {
        ["Init module data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
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
        , ["_fobs", [], [[]]]
    ];

    // Otherwise start applying the saved data
    if (KPLIB_param_debug) then {
        ["Init module data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
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
        ["Additional military sectors or unlockable vehicles detected and assigned", "IMPORTANT"] call KPLIB_fnc_common_log;
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
    // Publish blufor sectors
    KPLIB_sectors_blufor = +_blufor;
    publicVariable "KPLIB_sectors_blufor";

    // TODO: TBD: considering, however, whether such data could be affixed as a persistent object variable...
    /* Assuming the FOB building itself lands correctly in the persistence
     * objects, then we also have the data corresponding to that FOB building. */

    KPLIB_sectors_fobs = +_fobs;

    // Publish FOB positions
    publicVariable "KPLIB_sectors_fobs";
};

true;
