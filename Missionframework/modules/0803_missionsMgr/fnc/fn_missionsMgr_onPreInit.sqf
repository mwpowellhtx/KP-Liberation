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

// // TODO: TBD: we may not need/want a refresh after all, so this one is probably unnecessary
// MVAR(_puslishMissions)                      = QMVAR(_puslishMissions);
MVAR(_onMissionsPublished)                  = QMVAR(_onMissionsPublished);


if (isServer) then {
    // Server side initialization
};

if (hasInterface) then {
    // Client side initialization

    MVAR(_enableOrDisablePeriod)            = 1;

    // Overview, success, and failure colors in that order
    MVAR(_ctBriefing_headerColors)          = [
        [0.35, 0.35, 0.35, 0.85]
        , [0, 0.4, 0.1333, 0.85]
        , [0.7, 0.14, 0, 0.85]
    ];

    // Assembly the row names and all of the control names
    MVAR(_ctBriefing_rowNames)              = [
        QMVAR(_ctBriefing_rowOverview)
        , QMVAR(_ctBriefing_rowSuccess)
        , QMVAR(_ctBriefing_rowFailure)
    ];

    private _briefingCtrlNames              = [
        Q(_headerBG)
        , Q(_rowBG)
        , Q(_lblTitle)
        , Q(_lblDescription)
    ];

    MVAR(_ctBriefing_allCtrlNames)          = [];

    {
        private _prefix = _x;
        MVAR(_ctBriefing_allCtrlNames) append (_briefingCtrlNames apply {
            [_prefix, _x] joinString "";
        });
    } forEach MVAR(_ctBriefing_rowNames);

    MVAR(_ctBriefing_titles)                = [
        localize "STR_KPLIB_MISSIONSMGR_BRIEFING_TITLE_OVERVIEW"
        , localize "STR_KPLIB_MISSIONSMGR_BRIEFING_TITLE_SUCCESS"
        , localize "STR_KPLIB_MISSIONSMGR_BRIEFING_TITLE_FAILURE"
    ];

    MPARAM(_debug)                          = false;
    MPARAM(_onLoad_debug)                   = false;
    MPARAM(_onUnload_debug)                 = false;
    MPARAM(_lnbMissions_onLoad_debug)       = false;
    MPARAM(_lnbMissions_onRefresh_debug)    = false;
    MPARAM(_lnbMissions_getData_debug)      = false;
    MPARAM(_onMissionsPublished_debug)      = false;

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
