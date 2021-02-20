/*
    KPLIB_fnc_productionsm_onPreInit

    File: fn_productionsm_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:55:40
    Last Update: 2021-02-18 20:55:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs module post initialization activites.

    Parameter(s):
        NONE

    Returns:
        Module event handler finished [BOOL]
 */

if (isServer) then {
    ["[fn_productionsm_onPostInit] Initializing...", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Refactored production server side event handlers

    // Client may add capability to a target factory sector
    ["KPLIB_productionsm_raiseAddCapability", KPLIB_fnc_productionsm_raiseAddCapability] call CBA_fnc_addEventHandler;

    // Client announces to the server that the manager dialog opened/closed...
    ["KPLIB_productionsm_onProductionMgrOpened", KPLIB_fnc_productionsm_onProductionMgrOpened] call CBA_fnc_addEventHandler;
    ["KPLIB_productionsm_onProductionMgrClosed", KPLIB_fnc_productionsm_onProductionMgrClosed] call CBA_fnc_addEventHandler;

    // Client may change the queue via the production manager
    ["KPLIB_productionsm_raiseChangeQueue", KPLIB_fnc_productionsm_raiseChangeQueue] call CBA_fnc_addEventHandler;

    [] call KPLIB_fnc_productionsm_create;
};

if (isServer) then {
    ["[fn_productionsm_onPostInit] Initializing...", "POST] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
