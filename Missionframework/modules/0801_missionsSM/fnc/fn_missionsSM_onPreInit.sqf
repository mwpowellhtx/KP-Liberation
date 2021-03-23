#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onPreInit

    File: fn_missionsSM_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2021-03-19 17:42:23
    Last Update: 2021-03-19 17:42:26
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
    ["Initializing...", "PRE] [MISSIONSSM", true] call KPLIB_fnc_common_log;
};

MVAR(_missionsMgrOpened)                = QMVAR(_missionsMgrOpened);
MVAR(_missionsMgrClosed)                = QMVAR(_missionsMgrClosed);
MVAR(_publishMissions)                  = QMVAR(_publishMissions);

MPARAM(_broadcastPeriodSeconds)         = 5;

if (isServer) then {

    MPARAM(_debug)                      = false;
    MPARAM(_createSM_debug)             = false;
    MPARAM(_onMissionsMgrOpened_debug)  = false;
    MPARAM(_onMissionsMgrClosed_debug)  = false;
    MPARAM(_onGetList_debug)            = false;
    MPARAM(_onBroadcast_debug)          = false;
    MPARAM(_onPublish_debug)            = false;
    MPARAM(_onState_debug)              = false;
    MPARAM(_onTransition_debug)         = false;
    MPARAM(_onNoOp_debug)               = false;

    MVAR(_configClassNameDefault)       = "KPLIB_missionsSM";
    MVAR(_objSM)                        = locationNull;
};

if (isServer) then {
    ["Initialized", "PRE] [MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
