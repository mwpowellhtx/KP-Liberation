/*
    KPLIB_fnc_logisticsMgr_onPostInit

    File: fn_logisticsMgr_onPostInit.sqf
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
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPerFrameHandler-sqf.html
 */

if (isServer) then {
    ["[fn_logisticsMgr_onPostInit] Initializing...", "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
    [] call KPLIB_fnc_logisticsMgr_setupPlayerMenu;

    ["KPLIB_logisticsMgr_onLinesPublished", KPLIB_fnc_logisticsMgr_onLinesPublished] call CBA_fnc_addEventHandler;
    [KPLIB_logisticsMgr_onEndpointsPublished, KPLIB_fnc_logisticsMgr_onEndpointsPublished] call CBA_fnc_addEventHandler;

    KPLIB_logisticsMgr_enableOrDisableCtrlsPeriod = 0.75;

    [KPLIB_fnc_logisticsMgr_onEnableOrDisableCtrls, KPLIB_logisticsMgr_enableOrDisableCtrlsPeriod] call CBA_fnc_addPerFrameHandler;
};

if (isServer) then {
    ["[fn_logisticsMgr_onPostInit] Initialized", "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
