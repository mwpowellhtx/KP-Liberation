// Mind the shorthand throughout...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onPreInit

    File: fn_missions_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:42:23
    Last Update: 2021-04-16 09:13:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMap
 */

if (isServer) then {
    ["Initializing...", "PRE] [MISSIONS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: should "missions" be supported as self-contained "namespaces" according to a "mission blueprint" (?)
// TODO: TBD: and then how much of that is server side, how much of that interfaces with client side? dialog? etc...
MVAR(_permissionName)                   = Q(Missions);

//                                        [S, A, F, I]
MVAR1(_zeroDebit)                       = [0, 0, 0, 0];
//                          _supplyDebit:  ^
//                          _ammoDebit:       ^
//                          _fuelDebit:          ^
//                          _intelDebit:            ^

// TODO: TBD: make this a proper CBA setting...
// Indicative of a mission rebate value, percentage of the cost which may be recouped on abort
MVAR1(_rebateValue)                     = 0.5;

// TODO: TBD: we may stand on "status"... maybe...
MSTATUS1(_standby)                      =   0;
MSTATUS1(_template)                     =   1;
MSTATUS1(_running)                      =   2;
MSTATUS1(_started)                      =   4;
MSTATUS1(_engaged)                      =   8;
MSTATUS1(_aborting)                     =  16;
MSTATUS1(_success)                      =  32;
MSTATUS1(_failure)                      =  64;
MSTATUS1(_completed)                    = 128;
/* System MISSIONS may not be aborted, they are typically triggered
 * by internal conditions and must evaluate to completion */
MSTATUS1(_gc)                           = 256;
MSTATUS1(_system)                       = 512;

MSTATUS1(_successFailureAborting)       = MSTATUS1(_success) + MSTATUS1(_failure) + MSTATUS1(_aborting);

// TODO: TBD: also consider which mission telemetry should be reported...
MVAR(_statusReports)                   = [
    [MSTATUS1(_standby)     , localize "STR_KPLIB_MISSION_STATUS_STANDBY"   ]
    , [MSTATUS1(_template)  , localize "STR_KPLIB_MISSION_STATUS_TEMPLATE"  ]
    , [MSTATUS1(_running)   , localize "STR_KPLIB_MISSION_STATUS_RUNNING"   ]
    , [MSTATUS1(_started)   , localize "STR_KPLIB_MISSION_STATUS_STARTED"   ]
    , [MSTATUS1(_engaged)   , localize "STR_KPLIB_MISSION_STATUS_ENGAGED"   ]
    , [MSTATUS1(_aborting)  , localize "STR_KPLIB_MISSION_STATUS_ABORTING"  ]
    , [MSTATUS1(_success)   , localize "STR_KPLIB_MISSION_STATUS_SUCCESS"   ]
    , [MSTATUS1(_failure)   , localize "STR_KPLIB_MISSION_STATUS_FAILURE"   ]
    , [MSTATUS1(_completed) , localize "STR_KPLIB_MISSION_STATUS_COMPLETED" ]
    , [MSTATUS1(_gc)        , localize "STR_KPLIB_MISSION_STATUS_GC"        ]
    , [MSTATUS1(_system)    , localize "STR_KPLIB_MISSION_STATUS_SYSTEM"    ]
];

MVAR1(_zeroBriefing)                    = ["", "", ""];

MPARAM(_debug)                          = false;

if (isServer) then {

    MPARAM(_onGetArrayTelemetry_debug)  = false;

    // TODO: TBD: may reconsider 'defaults' in this sense in favor of a more functional approach
    // TODO: TBD: in that way settings may be 'set' and missions may keep on rolling normally
    /*
     * KPLIB_mission_uuid - used to identify a mission
     * KPLIB_mission_templateUuid - used as a reference for the template mission
     * KPLIB_mission_serverTime - server time at which the instance was created
     * KPLIB_mission_icon - may inform enumerated missions in the list
     * KPLIB_mission_name - like a 'variable name' but uniquely identifying the mission
     * KPLIB_mission_title - human readable title
     * KPLIB_mission_briefing - mission briefing consisting of, [_overview, _success, _failure]
     * KPLIB_mission_imagePath - for use in the mission briefing
     * KPLIB_mission_args - relay for arguments passed to running mission
     * KPLIB_mission_cost - [S, A, F, I]
     * KPLIB_mission_range - baseline range informs mission geometry
     * KPLIB_mission_status - default status during registration, typically a MISSION TEMPLATE
     * KPLIB_mission_timer - for time sensitive missions
     * KPLIB_fnc_mission_* - callbacks regulating entry point and state machine states, transisions, etc
     */
    MVAR1(_nameValuePairDefaults) = +[
        [QMVAR1(_uuid)                      , ""                                ]
        , [QMVAR1(_templateUuid)            , ""                                ]
        , [QMVAR1(_serverTime)              , -1                                ]
        , [QMVAR1(_icon)                    , ""                                ]
        , [QMVAR1(_name)                    , ""                                ]
        , [QMVAR1(_title)                   , ""                                ]
        , [QMVAR1(_briefing)                , MVAR1(_zeroBriefing)              ]
        , [QMVAR1(_imagePath)               , ""                                ]
        , [QMVAR1(_args)                    , []                                ]
        , [QMVAR1(_cost)                    , MVAR1(_zeroDebit)                 ]
        , [QMVAR1(_pos)                     , KPLIB_zeroPos                     ]
        , [QMVAR1(_range)                   , KPLIB_param_sectors_capRange      ]
        , [QMVAR1(_status)                  , MSTATUS1(_template)               ]
        , [QMVAR1(_timer)                   , KPLIB_timers_default              ]
        , [QMFUNC1(_onGetTelemetry)         , MFUNC1(_onNoOpTelemetry)          ]
        , [QMFUNC1(_onSetupEntered)         , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onSetup)                , MFUNC1(_onNoOpSetup)              ]
        , [QMFUNC1(_onSetupLeaving)         , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onMissionEntered)       , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onMission)              , MFUNC1(_onNoOpMission)            ]
        , [QMFUNC1(_onMissionLeaving)       , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onTearDownEntered)      , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onTearDown)             , MFUNC1(_onNoOpTearDown)           ]
        , [QMFUNC1(_onTearDownLeaving)      , MFUNC1(_onNoOp)                   ]
        , [QMFUNC1(_onCompleteEntered)      , MFUNC1(_onNoOp)                   ]
    ];

    MVAR1(_variablesNamesToClone) = [
        QMVAR1(_templateUuid)
        , QMVAR1(_serverTime)
        , QMVAR1(_icon)
        , QMVAR1(_name)
        , QMVAR1(_title)
        , QMVAR1(_briefing)
        , QMVAR1(_imagePath)
        , QMVAR1(_args)
        , QMVAR1(_cost)
        , QMVAR1(_pos)
        , QMVAR1(_range)
        , QMVAR1(_status)
        , QMVAR1(_timer)
        , QMFUNC1(_onGetTelemetry)
        , QMFUNC1(_onSetupEntered)
        , QMFUNC1(_onSetup)
        , QMFUNC1(_onSetupLeaving)
        , QMFUNC1(_onMissionEntered)
        , QMFUNC1(_onMission)
        , QMFUNC1(_onMissionLeaving)
        , QMFUNC1(_onTearDownEntered)
        , QMFUNC1(_onTearDown)
        , QMFUNC1(_onTearDownLeaving)
        , QMFUNC1(_onCompleteEntered)
    ];

    /* These are the core variables which get bundled together for publication to managers.
     * Intentionally does not include TELEMETRY comprehension, because that is a separate
     * matter, dependent on whether the MISSION is a TEMPLATE, RUNNING, and the specific
     * state of each running mission. Basically we want to capture everything excepting for
     * actual live code, callbacks, things of this nature. */

    // Rearranged a tiny bit to better accommodate the user interface
    MVAR1(_variableNamesToPublish) = +[
        [QMVAR1(_uuid)          , ""                    ]
        , [QMVAR1(_templateUuid), ""                    ]
        , [QMVAR1(_icon)        , ""                    ]
        , [QMVAR1(_title)       , ""                    ]
        , [QMVAR1(_pos)         , KPLIB_zeroPos         ]
        , [QMVAR1(_status)      , MSTATUS1(_standby)    ]
        , [QMVAR1(_timer)       , KPLIB_timers_default  ]
        , [QMVAR1(_briefing)    , MVAR1(_zeroBriefing)  ]
        , [QMVAR1(_imagePath)   , ""                    ]
    ];

    // Register key event handlers
    ["KPLIB_doLoad", {[] call MFUNC(_onLoadData);}] call CBA_fnc_addEventHandler;
    ["KPLIB_doSave", {[] call MFUNC(_onSaveData);}] call CBA_fnc_addEventHandler;

    private _createRegistry = {
        private _map = createHashMap;
        // TODO: TBD: actually, on second thought, do not need to mess with "registered items"
        // TODO: TBD: we can work with keys, and select out a list of items from that
        // TODO: TBD: then separate based on template/running, and order by server time
        //_map set [QMVAR1(_registeredItems), []];
        _map;
    };

    /* Captures both MISSION TEMPLATES as well as RUNNING MISSIONS. We gather them together
     * in a single HASHMAP registry primarily for easier maintenance throughout the API, and
     * so we must also be careful to discern based upon QMVAR1(_status), but also be mindful
     * of QMVAR1(_uuid) as well as QMVAR1(_templateUuid). */

    MVAR(_registry)             = [] call _createRegistry;
};

// Process CBA Settings
[] call MFUNC(_settings);

if (isServer) then {
    ["Initialized", "PRE] [MISSIONS", true] call KPLIB_fnc_common_log;
};

true;
