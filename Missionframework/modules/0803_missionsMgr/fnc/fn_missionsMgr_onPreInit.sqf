#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_onPreInit

    File: fn_missionsMgr_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
 */

if (isServer) then {
    ["Initializing...", "PRE] [MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

MVAR(_permissionName)                       = "Mission";

MVAR(_puslishMissions)                      = QMVAR(_puslishMissions);

if (isServer) then {
    // Server side initialization
};

if (hasInterface) then {
    // Client side initialization

    MVAR(_enableOrDisablePeriod)            = 1;

    MVAR(_onLoad_debug)                     = false;
    MVAR(_onUnload_debug)                   = false;
    MVAR(_lnbMissions_onLoad_debug)         = false;
    MVAR(_lnbMissions_getData_debug)        = false;

    MVAR(_allIdcs) = [
        KPLIB_IDC_MISSIONSMGR_LNB_MISSIONS
        , KPLIB_IDC_MISSIONSMGR_BTN_RUN
        , KPLIB_IDC_MISSIONSMGR_BTN_ABORT
        , KPLIB_IDC_MISSIONSMGR_GRP_BRIEFING
        , KPLIB_IDC_MISSIONSMGR_LBL_TITLE
        , KPLIB_IDC_MISSIONSMGR_LNB_TELEMETRY
        , KPLIB_IDC_MISSIONSMGR_IMG_MISSION
        , KPLIB_IDC_MISSIONSMGR_LNB_BRIEFING
    ];

    MVAR(_runIdcs) = [
        KPLIB_IDC_MISSIONSMGR_BTN_RUN
    ];

    MVAR(_abortIdcs) = [
        KPLIB_IDC_MISSIONSMGR_BTN_ABORT
    ];
};

if (isServer) then {
    ["Initialized", "PRE] [MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

true;
