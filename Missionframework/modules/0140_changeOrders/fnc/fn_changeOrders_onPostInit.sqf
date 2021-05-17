/*
    KPLIB_fnc_changeOrders_onPostInit

    File: fn_changeOrders_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:35:37
    Last Update: 2021-03-06 09:35:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["[fn_changeOrders_onPostInit] Initializing...", "POST] [CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_changeOrders_onPostInit] Initialized", "POST] [CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

true;
