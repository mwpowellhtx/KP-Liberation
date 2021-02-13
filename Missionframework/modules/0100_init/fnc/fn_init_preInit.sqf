/*
    KPLIB_fnc_init_preInit

    File: fn_init_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2017-08-31
    Last Update: 2021-01-28 15:11:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

// TODO: TBD: "init" and its pre- and post-init handlers is probably the correct timing in all of this...
// TODO: TBD: which potentially beggards the question re: better module factoring for some of the other foundational functions...

if (isServer) then {
    ["Module initializing...", "PRE] [INIT", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
*/

// Name of the save key inside of the [ServerProfileName].vars.Arma3Profile file.
KPLIB_save_key = format [localize "STR_SAVE_KEY", toUpper worldName];
// Variable for ending the campaign
KPLIB_campaignRunning = true;
// Reset position shortcut
KPLIB_resetPos = [99999,99999,0];
// Indicator if the saved data is fully loaded
KPLIB_save_loaded = false;
// Spawnpoints for air vehicles
KPLIB_sectors_airspawn = [];
// All capturable sectors
KPLIB_sectors_all = [];
// All active sectors
KPLIB_sectors_active = [];
// Sectors which are captured by blufor
KPLIB_sectors_blufor = [];
// All city sectors
KPLIB_sectors_city = [];
// All factory sectors
KPLIB_sectors_factory = [];
// Locked vehicles <-> military bases connection array
KPLIB_sectors_lockedVeh = [];
// Markers for the locked vehicles
KPLIB_sectors_lockedVehMarkers = [];
// All metropolis (capitol) sectors
KPLIB_sectors_metropolis = [];
// All military sectors
KPLIB_sectors_military = [];
// Spawnpoints for secondary missions and enemy forces
KPLIB_sectors_spawn = [];
// All radiotowers
KPLIB_sectors_tower = [];
// Zero position shortcut
KPLIB_zeroPos = [0,0,0];


/*
    ----- Module Initialization -----
*/

// Execute config guard function
[] call KPLIB_fnc_init_configGuard;

// Check for ACE
KPLIB_ace_enabled = isClass (configFile >> "CfgPatches" >> "ace_main");
KPLIB_ace_medical = isClass (configfile >> "CfgPatches" >> "ace_medical");

// Check for KP Ranks
KPLIB_kpr_enabled = isClass (configFile >> "CfgPatches" >> "KP_Ranks");

// Process CBA Settings
[] call KPLIB_fnc_init_settings;

// Read the KPLIB_config.sqf file
[] call compile preprocessFileLineNumbers "KPLIB_config.sqf";

// Parameter processing and vanilla save deactivation on the server only
if (isServer) then {
    enableSaving [false, false];

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_init_loadData;}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_init_saveData;}] call CBA_fnc_addEventHandler;

    // Load preset files
    [] call KPLIB_fnc_init_loadPresets;
};

if (isServer) then {
    ["Module initialized", "PRE] [INIT", true] call KPLIB_fnc_common_log;
};

true
