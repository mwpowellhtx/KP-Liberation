#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_createSM

    File: fn_missionsSM_createSM.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 13:04:48
    Last Update: 2021-03-20 13:04:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the CBA MISSIONS state machine from the specified configuration '_className'.

    Parameter(s):
        _className - the configuration state machine class name [STRING, default: KPLIB_missionsSM_configClassNameDefault]

    Returns:
        The CBA MISSIONS state machine object [LOCATION]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

private _debug = [
    [
        {MPARAM(_createSM_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_className), MVAR(_configClassNameDefault), [""]]
];

if (_debug) then {
    [format ["[fn_missionsSM_createSM] Entering: [_className]: %1"
        , str [_className]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

// Only load the configuration once when required to do so
MVAR(_configSM) = missionConfigFile >> "CfgStateMachines" >> "KPLIB" >> _className;

MVAR(_objSM) = [MVAR(_configSM)] call CBA_statemachine_fnc_createFromConfig;

// Publication originates from the statemachine object itself
MVAR(_objSM) setVariable [QMVAR(_publicationTimer), (+KPLIB_timers_default)];

if (_debug) then {
    ["[fn_missionsSM_createSM] Finished", "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

MVAR(_objSM);
