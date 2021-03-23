// Mind the shorthand throughout...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onPreInit

    File: fn_missions_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:42:23
    Last Update: 2021-03-19 17:42:26
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
MVAR(_permissionName)                   = Q(Mission);

//                                        [S, A, F, I]
MVAR(_zeroDebit)                        = [0, 0, 0, 0];
//                          _supplyDebit:  ^
//                          _ammoDebit:       ^
//                          _fuelDebit:          ^
//                          _intelDebit:            ^

// TODO: TBD: make this a proper CBA setting...
// Indicative of a mission rebate value, percentage of the cost which may be recouped on abort
MVAR(_rebateValue)                      = 0.5;

// TODO: TBD: we may stand on "status"... maybe...
MSTATUS(_standby)                       =   0;
MSTATUS(_template)                      =   1;
MSTATUS(_running)                       =   2;
MSTATUS(_started)                       =   4;
MSTATUS(_engaged)                       =   8;
MSTATUS(_aborting)                      =  16;
MSTATUS(_success)                       =  32;
MSTATUS(_failure)                       =  64;
MSTATUS(_completed)                     = 128;

// TODO: TBD: also consider which mission telemetry should be reported...
MSVAR(_statusReports)                   = [
    [MSTATUS(_standby)      , localize "STR_KPLIB_MISSION_STATUS_STANDBY"   ]
    , [MSTATUS(_template)   , localize "STR_KPLIB_MISSION_STATUS_TEMPLATE"  ]
    , [MSTATUS(_running)    , localize "STR_KPLIB_MISSION_STATUS_RUNNING"   ]
    , [MSTATUS(_started)    , localize "STR_KPLIB_MISSION_STATUS_STARTED"   ]
    , [MSTATUS(_engaged)    , localize "STR_KPLIB_MISSION_STATUS_ENGAGED"   ]
    , [MSTATUS(_aborting)   , localize "STR_KPLIB_MISSION_STATUS_ABORTING"  ]
    , [MSTATUS(_success)    , localize "STR_KPLIB_MISSION_STATUS_SUCCESS"   ]
    , [MSTATUS(_failure)    , localize "STR_KPLIB_MISSION_STATUS_FAILURE"   ]
    , [MSTATUS(_completed)  , localize "STR_KPLIB_MISSION_STATUS_COMPLETED" ]
];

MVAR(_zeroBriefing)                     = ["", "", ""];

MSPARAM(_debug)                         = false;

if (isServer) then {

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
    MVAR(_nameValuePairDefaults) = +[
        [QMVAR(_uuid)                   , ""                        ]
        , [QMVAR(_templateUuid)         , ""                        ]
        , [QMVAR(_serverTime)           , -1                        ]
        , [QMVAR(_icon)                 , ""                        ]
        , [QMVAR(_name)                 , ""                        ]
        , [QMVAR(_title)                , ""                        ]
        , [QMVAR(_briefing)             , MVAR(_zeroBriefing)       ]
        , [QMVAR(_imagePath)            , ""                        ]
        , [QMVAR(_args)                 , []                        ]
        , [QMVAR(_cost)                 , MVAR(_zeroDebit)          ]
        , [QMVAR(_pos)                  , KPLIB_zeroPos             ]
        , [QMVAR(_range)                , KPLIB_param_sectorCapRange]
        , [QMVAR(_status)               , MSTATUS(_template)        ]
        , [QMVAR(_timer)                , KPLIB_timers_default      ]
        , [QMFUNC(_onGetTelemetry)      , MSFUNC(_onNoTelemetry)    ]
        , [QMFUNC(_onEnterMission)      , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onAbortMission)      , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onMissionSetup)      , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onMissionEntered)    , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onMission)           , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onMissionLeaving)    , MSFUNC(_onNoOp)           ]
        , [QMFUNC(_onMissionTearDown)   , MSFUNC(_onNoOp)           ]
    ];

    MVAR(_variablesNamesToClone) = [
        QMVAR(_icon)
        , QMVAR(_templateUuid)
        , QMVAR(_serverTime)
        , QMVAR(_name)
        , QMVAR(_title)
        , QMVAR(_briefing)
        , QMVAR(_imagePath)
        , QMVAR(_args)
        , QMVAR(_cost)
        , QMVAR(_pos)
        , QMVAR(_radius)
        , QMVAR(_status)
        , QMVAR(_timer)
        , QMFUNC(_onIsComplete)
        , QMFUNC(_onIsFailed)
        , QMFUNC(_onEnterMission)
        , QMFUNC(_onAbortMission)
        , QMFUNC(_onMissionSetup)
        , QMFUNC(_onMissionEntered)
        , QMFUNC(_onMission)
        , QMFUNC(_onMissionLeaving)
        , QMFUNC(_onMissionTearDown)
    ];

    /* These are the core variables which get bundled together for publication to managers.
     * Intentionally does not include TELEMETRY comprehension, because that is a separate
     * matter, dependent on whether the MISSION is a TEMPLATE, RUNNING, and the specific
     * state of each running mission. Basically we want to capture everything excepting for
     * actual live code, callbacks, things of this nature. */

    // Rearranged a tiny bit to better accommodate the user interface
    MVAR(_variableNamesToPublish) = +[
        [QMVAR(_uuid)           , ""                    ]
        , [QMVAR(_templateUuid) , ""                    ]
        , [QMVAR(_icon)         , ""                    ]
        , [QMVAR(_title)        , ""                    ]
        , [QMVAR(_pos)          , KPLIB_zeroPos         ]
        , [QMVAR(_status)       , MSTATUS(_standby)     ]
        , [QMVAR(_timer)        , KPLIB_timers_default  ]
        , [QMVAR(_briefing)     , MVAR(_zeroBriefing)   ]
        , [QMVAR(_imagePath)    , ""                    ]
    ];

    // Register key event handlers
    ["KPLIB_doLoad", {[] call MSFUNC(_onLoadData);}] call CBA_fnc_addEventHandler;
    ["KPLIB_doSave", {[] call MSFUNC(_onSaveData);}] call CBA_fnc_addEventHandler;

    private _createRegistry = {
        private _map = createHashMap;
        // TODO: TBD: actually, on second thought, do not need to mess with "registered items"
        // TODO: TBD: we can work with keys, and select out a list of items from that
        // TODO: TBD: then separate based on template/running, and order by server time
        //_map set [QMVAR(_registeredItems), []];
        _map;
    };

    /* Captures both MISSION TEMPLATES as well as RUNNING MISSIONS. We gather them together
     * in a single HASHMAP registry primarily for easier maintenance throughout the API, and
     * so we must also be careful to discern based upon QMVAR(_status), but also be mindful
     * of QMVAR(_uuid) as well as QMVAR(_templateUuid). */

    MSVAR(_registry)            = [] call _createRegistry;
};

// Process CBA Settings
[] call MSFUNC(_settings);

if (isServer) then {
    ["Initialized", "PRE] [MISSIONS", true] call KPLIB_fnc_common_log;
};

true;
