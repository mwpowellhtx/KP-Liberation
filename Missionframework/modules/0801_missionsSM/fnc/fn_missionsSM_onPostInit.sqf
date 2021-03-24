#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onPostInit

    File: fn_missionsSM_onPostInit.sqf
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
        Module postInit finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["Initializing...", "POST] [MISSIONSSM", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    // Client announces to the server that the manager dialog opened/closed...
    [MVAR(_missionsMgrOpened)   , MFUNC(_onMissionsMgrOpened)] call CBA_fnc_addEventHandler;
    [MVAR(_missionsMgrClosed)   , MFUNC(_onMissionsMgrClosed)] call CBA_fnc_addEventHandler;

    // For better readability
    MFUNC(_onSetup)             = MFUNC(_onState);
    MFUNC(_onMission)           = MFUNC(_onState);
    MFUNC(_onTearDown)          = MFUNC(_onState);

    MFUNC(_onSetupEntered)      = MFUNC(_onTransition);
    MFUNC(_onSetupLeaving)      = MFUNC(_onTransition);
    MFUNC(_onMissionEntered)    = MFUNC(_onTransition);
    MFUNC(_onMissionLeaving)    = MFUNC(_onTransition);
    MFUNC(_onTearDownEntered)   = MFUNC(_onTransition);
    MFUNC(_onTearDownLeaving)   = MFUNC(_onTransition);
    MFUNC(_onCompleteEntered)   = MFUNC(_onTransition);

    // // TODO: TBD: not just yet, at least while we are working out initial client/server manager integration
    [] call MFUNC(_createSM);
};

if (hasInterface) then {
    // Client side init
};

if (isServer) then {
    ["Initialized", "POST] [MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
