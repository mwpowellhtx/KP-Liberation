/*
    KPLIB_fnc_logistic_onPreInit

    File: fn_logistic_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-01-16
    Last Update: 2021-05-19 08:42:36
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
    ["[fn_logistic_onPreInit] Initializing...", "PRE] [LOGISTIC", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Initialization -----
 */

if (isServer) then {
    // Adding actions to created logistic buildings
    ["KPLIB_vehicle_created", { _this call KPLIB_fnc_logistic_addActions;}] call CBA_fnc_addEventHandler;

    KPLIB_logistic_data = true call CBA_fnc_createNamespace;
    publicVariable "KPLIB_logistic_data";
};

// Process CBA Settings
[] call KPLIB_fnc_logistic_settings;

/*
    ----- Module Globals -----
 */

KPLIB_logistic_building = KPLIB_preset_logiBuildingF;
KPLIB_logistic_activeCam = objNull;

if (isServer) then {
    ["[fn_logistic_onPreInit] Initialized", "PRE] [LOGISTIC", true] call KPLIB_fnc_common_log;
};

true;
