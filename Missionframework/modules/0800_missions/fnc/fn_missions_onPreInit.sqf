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
 */

if (isServer) then {
    ["Initializing...", "PRE] [MISSIONS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: should "missions" be supported as self-contained "namespaces" according to a "mission blueprint" (?)
// TODO: TBD: and then how much of that is server side, how much of that interfaces with client side? dialog? etc...
MVAR(_permissionName)               = Q(Mission);

//                                    [S, A, F, I]
MVAR(_zeroDebit)                    = [0, 0, 0, 0];
//                      _supplyDebit:  ^
//                      _ammoDebit:       ^
//                      _fuelDebit:          ^
//                      _intelDebit:            ^

// TODO: TBD: make this a proper CBA setting...
// Indicative of a mission rebate value, percentage of the cost which may be recouped on abort
MVAR(_rebateValue)                  = 0.5;

// TODO: TBD: we may stand on "status"... maybe...
MSTATUS(_standby)                   =  0;
MSTATUS(_started)                   =  1;
MSTATUS(_engaged)                   =  2;
MSTATUS(_completed)                 =  4;
MSTATUS(_failure)                   =  8;
MSTATUS(_success)                   = 16;
MSTATUS(_aborting)                  = 32;

if (isServer) then {

    MSVAR(_nameValuePairDefaults) = +[
        [QMVAR(_uuid)                   , ""                        ]
        , [QMVAR(_templateUuid)         , ""                        ]
        , [QMVAR(_args)                 , []                        ]
        , [QMVAR(_cost)                 , MVAR((_zeroDebit)         ]
        , [QMVAR(_pos)                  , KPLIB_zeroPos             ]
        , [QMVAR(_radius)               , KPLIB_param_sectorCapRange]
        , [QMVAR(_status)               , MSTATUS(_standby)         ]
        , [QMVAR(_timer)                , KPLIB_timers_disabled     ]
        , [QMVAR_F(_onEnterMission)     , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onAbortMission)     , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onMissionSetup)     , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onMissionEntered)   , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onMission)          , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onMissionLeaving)   , MSVAR_F(_onNoOp)          ]
        , [QMVAR_F(_onMissionTearDown)  , MSVAR_F(_onNoOp)          ]
    ];

    MSVAR(_variablesNamesToClone) = [
        QMVAR(_templateUuid)
        , QMVAR(_args)
        , QMVAR(_cost)
        , QMVAR(_pos)
        , QMVAR(_radius)
        , QMVAR(_status)
        , QMVAR(_timer)
        , QMVAR_F(_onIsComplete)
        , QMVAR_F(_onIsFailed)
        , QMVAR_F(_onEnterMission)
        , QMVAR_F(_onAbortMission)
        , QMVAR_F(_onMissionSetup)
        , QMVAR_F(_onMissionEntered)
        , QMVAR_F(_onMission)
        , QMVAR_F(_onMissionLeaving)
        , QMVAR_F(_onMissionTearDown)
    ];

    // Register key event handlers
    ["KPLIB_doLoad", {[] call MSVAR_F(_onLoadData);}] call CBA_fnc_addEventHandler;
    ["KPLIB_doSave", {[] call MSVAR_F(_onSaveData);}] call CBA_fnc_addEventHandler;

    MSVAR(_namespaces) = [];
};

// Process CBA Settings
[] call MSVAR_F(_settings);

if (isServer) then {
    ["Initialized", "PRE] [MISSIONS", true] call KPLIB_fnc_common_log;
};

true;
