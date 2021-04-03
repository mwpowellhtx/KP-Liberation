#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblTimer_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblTimer), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onLoad] Entering: [isNull _lblTimer, isNull _config, _className]: %1"
        , str [isNull _lblTimer, isNull _config, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

// Keep the CONTROL and its CONFIG for bookkeeping purposes later on
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblTimer),_lblTimer];
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblTimerConfig),_config];

[_lblTimer] call MFUNC2(Sector,_ctrlsGrpSector_lblTimer_onRefresh);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onLoad] Fini: [ctrlIDC _lblTimer]: %1"
        , str [ctrlIDC _lblTimer]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
