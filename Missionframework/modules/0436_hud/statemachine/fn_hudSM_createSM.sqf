#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_createSM

    File: fn_hudSM_createSM.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:05:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a configuration based CBA state machine.

    Parameters:
        _className - the module state machine class name [STRING, default: MVAR(_className)]

    Returns:
        The created state machine [LOCATION, default: locationNull]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

params [
    [Q(_className), MVAR(_className), [""]]
];

// TODO: TBD: could really stand to have a state machine module...
// TODO: TBD: especially now that we have enough of them operating and pretty effectively...

// Only load the configuration once when required to do so
private _configSM = [missionConfigFile >> "CfgStateMachines" >> "KPLIB" >> _className] call {
    params [
        [Q(_config), configNull, [configNull]]
    ];
    MVAR(_configSM) = _config;
    MVAR(_configSM);
};

// TODO: TBD: potentially contain a SM module, with at least two functions...
// TODO: TBD: 1. load the config
// TODO: TBD: 1. load the SM itself
private _objSM = [_configSM] call {
    params [
        [Q(_config), configNull, [configNull]]
    ];

    MVAR(_objSM) = [_config] call CBA_statemachine_fnc_createFromConfig;
    private _objSM = MVAR(_objSM);

    _objSM;
};

_objSM;
