/*
    KPLIB_fnc_core_onPreInit

    File: fn_core_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-18
    Last Update: 2021-05-19 11:27:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_core_onPreInit] Initializing...", "PRE] [CORE", true] call KPLIB_fnc_common_log;
};

// Process CBA Settings
[] call KPLIB_fnc_core_settings;

if (isServer) then {

    KPLIB_preset_core_maxGrpCount = 288;

    ["KPLIB_vehicle_created", { _this call KPLIB_fnc_core_handleVehicleSpawn; }] call CBA_fnc_addEventHandler;

    if (KPLIB_param_clearVehicleCargo) then {
        ["KPLIB_vehicle_created", { _this call KPLIB_fnc_common_clearVehicleCargo; }] call CBA_fnc_addEventHandler;
    };
};

/*
    ----- Module Globals -----
 */

// TODO: TBD: instead of tracking an object, might consider a variable on the vehicle...
// TODO: TBD: just "one" reference?
// Potato 01 vehicle reference
KPLIB_core_potato01 = objNull;
// Deploy button trigger for redeploy dialog
KPLIB_dialog_deploy = 0;

// TODO: TBD: Refactor to first class config function...
KPLIB_fnc_core_onUpdateMobileRespawnMarkers = {};

if (isServer) then {

    /*
     * KPLIB_asset_isMobileRespawn, indicates whether an asset is considered to be a mobile respawn.
     *
     */
    [["KPLIB_asset_isMobileRespawn"], true] call KPLIB_fnc_persistence_addPersistentVars;

    //// TODO: TBD: not sure quite what the thought process was that included factory markers... these are simple 'sectors'
    //["KPLIB_updateMarkers", {[] call KPLIB_fnc_core_updateFactoryMarkers;}] call CBA_fnc_addEventHandler;

    ["KPLIB_updateMarkers", { [] call KPLIB_fnc_core_onUpdateMobileRespawnMarkers; }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_core_onPreInit] Initialized", "PRE] [CORE", true] call KPLIB_fnc_common_log;
};

true;
