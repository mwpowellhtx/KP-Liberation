/*
    KPLIB_fnc_persistence_preInit

    File: fn_persistence_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-02-02
    Last Update: 2021-05-18 17:04:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
 */

if (isServer) then {
    ["[fn_persistence_preInit] Initializing...", "PRE] [PERSISTENCE", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

/*
    ----- Module Initialization -----
 */

[] call KPLIB_fnc_persistence_settings;

// Server section (dedicated and player hosted)
if (isServer) then {

    // TODO: TBD: should be server side only (?)
    KPLIB_persistence_objects = [];
    KPLIB_persistence_units = [];

    // TODO: TBD:
    // static turrets: ["B_GMG_01_F","GMG_01_base_F","GMG_TriPod","StaticGrenadeLauncher","StaticWeapon","LandVehicle","Land","AllVehicles","All"]
    // portable helipad lights: ["Land_PortableHelipadLight_01_F","FloatingStructure_F","All"]
    // helipad: ["Helipad_base_F","HeliH","NonStrategic","Building","Static","All"]
    // lights: ["Land_LampAirport_off_F","Lamps_base_F","House_Small_F","House_F","House","HouseBase","NonStrategic","Building","Static","All"]
    // portable lights: ["Land_PortableLight_single_F","Lamps_base_F","House_Small_F","House_F","House","HouseBase","NonStrategic","Building","Static","All"]
    // ...: ["Lamps_base_F","House_Small_F","House_F","House","HouseBase","NonStrategic","Building","Static","All"]

    // TODO: TBD: with the exception of maybe helipad lights, best we could maybe do there is "FloatingStructure_F" which is even a bit too specific, but "All" is way too general as well

    // TODO: TBD: perhaps instead of restricting "kinds of" we do examine for those variables, i.e. "KPLIB_fobUuid"
    // TODO: TBD: concerning unmanned, i.e. 'UAV', 'UGV' ...
    // These are the biggies...
    KPLIB_persistence_kindsOf = [
        "Building"
        , "Ground"
        , "Air"
        , "Ship"
    ];

    // [bin\config.bin,bin\config.bin/CfgVehicles,bin\config.bin/CfgVehicles/Land_PortableLight_double_F]

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_persistence_loadData;}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_persistence_saveData;}] call CBA_fnc_addEventHandler;

    // Add ACE persistent variables
    [[
        "ace_rearm_magazineSupply"
        , "ace_rearm_currentSupply"
        , "ace_refuel_currentFuelCargo"]] call KPLIB_fnc_persistence_addPersistentVars;

    /*
     * KPLIB_captured, indicates whether an asset is considered to have been seized.
     *      When within range of an FOB zone, the asset will be staged for persistence during
     *      the save and load phases. Seized civilian assets can also incur a reputation penalty.
     */
    [["KPLIB_captured"], true] call KPLIB_fnc_persistence_addPersistentVars;
};

if (isServer) then {
    ["[fn_persistence_preInit] Initialized", "PRE] [PERSISTENCE", true] call KPLIB_fnc_common_log;
};

true;
