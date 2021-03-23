// Mind the shorthand throughout...
#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onPreInit

    File: fn_firedrill_onPreInit.sqf
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
    ["Initializing...", "PRE] [FIREDRILL", true] call KPLIB_fnc_common_log;
};

// Call to setup some settings
[] call MFUNC(_settings);

if (isServer) then {
    // Server side init

    MPARAM(_debug)                          = true;
    MPARAM(_onSetup_debug)                  = true;
    MPARAM(_onMission_debug)                = true;
    MPARAM(_onTearDown_debug)               = true;
    MPARAM(_onCompleteEntered_debug)        = true;
    MPARAM(_onGetTelemetry_debug)           = true;

    // TODO: TBD: 'actual' missions would also fill in other bits, i.e. cost, etc
    MVAR(_variableNamesToInit) = +[
        [QPVAR1(_name)                      , localize "STR_KPLIB_MISSION_FIREDRILL_NAME"   ]
        , [QPVAR1(_title)                   , localize "STR_KPLIB_MISSION_FIREDRILL_TITLE"  ]
        , [
            QPVAR1(_briefing)               , [
                localize "STR_KPLIB_MISSION_FIREDRILL_BRIEFING_OVERVIEW_TEXT"
                , localize "STR_KPLIB_MISSION_FIREDRILL_BRIEFING_SUCCESS_TEXT"
                , localize "STR_KPLIB_MISSION_FIREDRILL_BRIEFING_FAILURE_TEXT"
            ]
                                                                                            ]
        , [QPFUNC1(_onSetup)                , MFUNC(_onSetup)                               ]
        , [QPFUNC1(_onMissionEntered)       , MFUNC(_onMissionEntered)                      ]
        , [QPFUNC1(_onMission)              , MFUNC(_onMission)                             ]
        , [QPFUNC1(_onTearDown)             , MFUNC(_onTearDown)                            ]
        , [QPFUNC1(_onCompleteEntered)      , MFUNC(_onCompleteEntered)                     ]
        , [QPFUNC1(_onGetTelemetry)         , MFUNC(_onGetTelemetry)                        ]
    ];
};

if (isServer) then {
    ["Initialized", "PRE] [FIREDRILL", true] call KPLIB_fnc_common_log;
};

true;
