// Mind the shorthand throughout...
#include "script_component.hpp"
/*
    KPLIB_fnc_exampleMission_onPreInit

    File: fn_exampleMission_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:43:24
    Last Update: 2021-03-20 16:43:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

if (isServer) then {
    ["Initializing...", "PRE] [EXAMPLEMISSION", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    MPARAM(_debug)                      = true;
    MPARAM(_onAbortMission_debug)       = true;
    MPARAM(_onEnterMission_debug)       = true;
    MPARAM(_onGetTelemetry_debug)       = true;
    MPARAM(_onMission_debug)            = true;
    MPARAM(_onMissionEntered_debug)     = true;
    MPARAM(_onMissionLeaving_debug)     = true;
    MPARAM(_onMissionSetup_debug)       = true;
    MPARAM(_onMissionTearDown_debug)    = true;

    // TODO: TBD: 'actual' missions would also fill in other bits, i.e. cost, etc
    MVAR(_variableNamesToInit) = +[
        [QPVAR(_name)                   , localize "STR_KPLIB_MISSION_EXAMPLE_NAME"             ]
        , [QPVAR(_title)                , localize "STR_KPLIB_MISSION_EXAMPLE_TITLE"            ]
        , [QPVAR(_briefingText)         , localize "STR_KPLIB_MISSION_EXAMPLE_BRIEFING_TEXT"    ]
        , [QPVAR(_successText)          , localize "STR_KPLIB_MISSION_EXAMPLE_SUCCESS_TEXT"     ]
        , [QPVAR(_failureText)          , localize "STR_KPLIB_MISSION_EXAMPLE_FAILURE_TEXT"     ]
        , [QPFUNC(_onGetTelemetry)      , MFUNC(_onGetTelemetry)                                ]
        , [QPFUNC(_onEnterMission)      , MFUNC(_onEnterMission)                                ]
        , [QPFUNC(_onAbortMission)      , MFUNC(_onAbortMission)                                ]
        , [QPFUNC(_onMissionSetup)      , MFUNC(_onMissionSetup)                                ]
        , [QPFUNC(_onMissionEntered)    , MFUNC(_onMissionEntered)                              ]
        , [QPFUNC(_onMission)           , MFUNC(_onMission)                                     ]
        , [QPFUNC(_onMissionLeaving)    , MFUNC(_onMissionLeaving)                              ]
        , [QPFUNC(_onMissionTearDown)   , MFUNC(_onMissionTearDown)                             ]
    ];
};

if (isServer) then {
    ["Initialized", "PRE] [EXAMPLEMISSION", true] call KPLIB_fnc_common_log;
};

true;
