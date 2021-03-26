#include "script_component.hpp"

// ...

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
    // No such thing as timers for purposes of client side HUD SM
    _objSM;
};

_objSM;
