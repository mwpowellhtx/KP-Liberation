/*
    KPLIB_fnc_productionSM_createSM

    File: fn_productionSM_createSM.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 10:32:35
    Last Update: 2021-02-19 10:32:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the CBA statemachine from the specified configuration '_className'.

    Parameter(s):
        _className - the configuration statemachine class name [STRING, default: KPLIB_productionSM_configClassNameDefault]

    Returns:
        The production CBA statemachine object [LOCATION]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

private _debug = [
    [
        {KPLIB_param_productionSM_createSM_debug}
    ]
] call KPLIB_fnc_productionSM_debug;

params [
    ["_className", KPLIB_productionSM_configClassNameDefault, [""]]
];

if (_debug) then {
    [format ["[fn_productionSM_createSM] Entering: [_className]: %1"
        , str [_className]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

KPLIB_productionSM_configSM = missionConfigFile >> "CfgStateMachines" >> "KPLIB" >> _className;

// TODO: TBD: we may want to test for the config path...
KPLIB_productionSM_objSM = [KPLIB_productionSM_configSM] call CBA_statemachine_fnc_createFromConfig;

// Publication originates from the statemachine object itself
KPLIB_productionSM_objSM setVariable ["KPLIB_productionSM_publicationTimer", (+KPLIB_timers_default)];

if (_debug) then {
    [format ["[fn_productionSM_createSM] Fini: [isNull KPLIB_productionSM_objSM, isNull KPLIB_productionSM_configSM]: %1"
        , str [isNull KPLIB_productionSM_objSM, isNull KPLIB_productionSM_configSM]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

KPLIB_productionSM_objSM;
