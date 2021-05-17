/*
    KPLIB_fnc_init_onPostInit

    File: fn_init_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-08-31
    Last Update: 2021-05-17 13:01:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (!isServer) then {
    // Called in the scheduled postInit environment allows the small wait in the function
    [] call KPLIB_fnc_init_receiveInit;
} else {
    ["[fn_init_onPostInit] Initializing...", "POST] [INIT", true] call KPLIB_fnc_common_log;

    // Sort the sector markers to category arrays
    [] call KPLIB_fnc_init_sortSectors;

    // Load current save
    [] call KPLIB_fnc_init_load;

    // TODO: TBD: per event handlers are potentially severe enough, should be its own module...
    // Add saveTimer per frame handler
    [{
        params ["_args", "_handle"];

        if (KPLIB_save_loaded && (time > 0)) then {
            if (KPLIB_campaignRunning) then {
                [] call KPLIB_fnc_init_save;
            } else {
                _handle call CBA_fnc_removePerFrameHandler;
                ["[fn_init_onPostInit] Save timer deactivated due to KPLIB_campaignRunning false", "IMPORTANT"] call KPLIB_fnc_common_log;
            };
        };
    }, KPLIB_param_saveInterval] call CBA_fnc_addPerFrameHandler;

    // Create locked vehicle markers
    [] call KPLIB_fnc_init_createLockedVehMarkers;

    // Place down Antennas at Radio Tower sectors
    [] call KPLIB_fnc_init_placeTowers;

    ["KPLIB_updateMarkers"] call CBA_fnc_serverEvent;

    ["[fn_init_onPostInit] Initialized", "POST] [INIT", true] call KPLIB_fnc_common_log;
};

// Player section
if (hasInterface) then {
    // Preload the arsenal to speed up arsenal opening during the game
    ["Preload"] call BIS_fnc_arsenal;
};

true;
