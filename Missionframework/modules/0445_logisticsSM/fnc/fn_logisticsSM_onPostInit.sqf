/*
    KPLIB_fnc_logisticsSM_onPostInit

    File: fn_logisticsSM_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
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
    ["[fn_logisticsSM_onPostInit] Initializing...", "POST] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)

    // TODO: TBD: replace "createNamespace" with "createStatemachine"...
    // TODO: TBD: but for now, do this, since we know it is a namespace...
    KPLIB_logisticsSM_namespace = [] call CBA_fnc_createNamespace;

    // Listen for client Logistics Manager dialog announcements...
    ["KPLIB_logistics_onLogisticsMgrOpened", KPLIB_fnc_logisticsSM_onLogisticsMgrOpened] call CBA_fnc_addEventHandler;
    ["KPLIB_logistics_onLogisticsMgrClosed", KPLIB_fnc_logisticsSM_onLogisticsMgrClosed] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logisticsSM_onPostInit] Initialized", "POST] [LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
