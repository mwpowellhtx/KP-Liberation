/*
    KPLIB_fnc_logisticsSM_createSM

    File: fn_logisticsSM_createSM.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 10:32:35
    Last Update: 2021-02-19 10:32:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the CBA statemachine from the specified configuration '_className'.

    Parameter(s):
        _className - the configuration statemachine class name [STRING, default: KPLIB_logisticsSM_configClassNameDefault]

    Returns:
        The production CBA statemachine object [LOCATION]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_createSM_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_className", KPLIB_logisticsSM_configClassNameDefault, [""]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_createSM] Entering: [_className]: %1"
        , str [_className]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// Only load the configuration once when required to do so
KPLIB_logisticsSM_configSM = missionConfigFile >> "CfgStateMachines" >> "KPLIB" >> _className;

// TODO: TBD: we may want to test for the config path...
KPLIB_logisticsSM_objSM = [KPLIB_logisticsSM_configSM] call CBA_statemachine_fnc_createFromConfig;

// Publication originates from the statemachine object itself
KPLIB_logisticsSM_objSM setVariable ["KPLIB_logisticsSM_publicationTimer", (+KPLIB_timers_default)];

if (_debug) then {
    ["[fn_logisticsSM_createSM] Finished", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

KPLIB_logisticsSM_objSM;
