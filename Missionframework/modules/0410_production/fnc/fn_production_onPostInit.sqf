/*
    KPLIB_fnc_production_onPostInit

    File: fn_production_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:17:39
    Last Update: 2021-02-16 22:29:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback regsitered on post initialization phase.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

if (isServer) then {
    ["[fn_production_onPostInit] Initializing...", "POST] [PRODUCTION", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Refactored production server event handlers
    ["KPLIB_productionServer_onAddCapability", KPLIB_fnc_productionServer_onAddCapability] call CBA_fnc_addEventHandler;
    ["KPLIB_productionServer_onRequestProduction", KPLIB_fnc_productionServer_onRequestProduction] call CBA_fnc_addEventHandler;
    ["KPLIB_productionServer_onRequestQueueChange", KPLIB_fnc_productionServer_onRequestQueueChange] call CBA_fnc_addEventHandler;

    [] call KPLIB_fnc_production_onCreateStatemachine;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    [] call KPLIB_fnc_production_setupPlayerMenu;
};

if (isServer) then {
    ["[fn_production_onPostInit] Initialized", "POST] [PRODUCTION", true] call KPLIB_fnc_common_log;
};

true;
