/*
    KPLIB_fnc_init_onPreInit

    File: fn_init_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-08-31
    Last Update: 2021-05-23 13:23:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

// TODO: TBD: "init" and its pre- and post-init handlers is probably the correct timing in all of this...
// TODO: TBD: which potentially beggards the question re: better module factoring for some of the other foundational functions...

if (isServer) then {
    ["[fn_init_onPreInit] Initializing...", "PRE] [INIT", true] call KPLIB_fnc_common_log;
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
// TODO: TBD: sector bits should be refactored to the SECTORS module...
// Spawnpoints for air vehicles
KPLIB_sectors_airspawn = [];
// All capturable sectors
KPLIB_sectors_all = [];
// All active sectors
KPLIB_sectors_active = [];
// Sectors which are captured by BLUFOR
KPLIB_sectors_blufor = [];
// Sectors which are considered OPFOR
KPLIB_sectors_opfor = [];
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
// For convenience used throughout user interface
KPLIB_zeroPosGridref = mapGridPosition KPLIB_zeroPos;
KPLIB_zeroPosGridrefDash = KPLIB_zeroPosGridref splitString "" apply { '-'; } joinString "";

// TODO: TBD: surprised that there is not the "grass cutter" defined in the build menu...
// Defined for use throughout
KPLIB_preset_proxyClassName = "Land_ClutterCutter_small_F";

KPLIB_init_saveEnabled = true;

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
    ["KPLIB_doLoad", { [] call KPLIB_fnc_init_loadData; }] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", { [] call KPLIB_fnc_init_saveData; }] call CBA_fnc_addEventHandler;

    ["KPLIB_updateMarkers", { [] call KPLIB_fnc_init_updateEdenMarkers; }] call CBA_fnc_addEventHandler;

    // Load preset files
    [] call KPLIB_fnc_init_loadPresets;
};

if (isServer) then {
    ["[fn_init_onPreInit] Initialized", "PRE] [INIT", true] call KPLIB_fnc_common_log;
};

true;
