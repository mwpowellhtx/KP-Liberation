/*
    KPLIB_fnc_core_preInit

    File: fn_core_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-18
    Last Update: 2021-04-22 14:43:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["Module initializing...", "PRE] [CORE", true] call KPLIB_fnc_common_log;
};

KPLIB_param_core_onRepackageFob_debug           = false;
KPLIB_param_core_onRepackageFob_onConfirm_debug = false;
KPLIB_param_core_onConfirmRepackageFob_debug    = false;

// Process CBA Settings
[] call KPLIB_fnc_core_settings;

if (isServer) then {

    [
        "KPLIB_vehicle_spawned"
        , {[_this select 0] call KPLIB_fnc_core_handleVehicleSpawn}
    ] call CBA_fnc_addEventHandler;

    if (KPLIB_param_clearVehicleCargo) then {
        [
            "KPLIB_vehicle_spawned"
            , {[_this select 0] call KPLIB_fnc_common_clearVehicleCargo}
        ] call CBA_fnc_addEventHandler;
    };

    KPLIB_core_fobMarkerType    = "b_hq";
    KPLIB_core_fobMarkerSize    = [1.5, 1.5];
    KPLIB_core_fobMarkerColor   = "ColorYellow";
    KPLIB_core_fobColor         = [0.85, 0.85, 0, 1];
    KPLIB_core_fobMarkerPath    = "\a3\ui_f\data\map\markers\handdrawn\flag_CA.paa";
};

/*
    ----- Module Globals -----
*/
KPLIB_fob_empty = +[
    ["", "", "", KPLIB_zeroPos]
    , [KPLIB_sectorType_nil, KPLIB_preset_sideF, systemTime apply {0}, KPLIB_uuid_zero]
];

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

    ["KPLIB_updateMarkers", {[] call KPLIB_fnc_core_onUpdateMobileRespawnMarkers;}] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["Module initialized", "PRE] [CORE", true] call KPLIB_fnc_common_log;
};

true;
