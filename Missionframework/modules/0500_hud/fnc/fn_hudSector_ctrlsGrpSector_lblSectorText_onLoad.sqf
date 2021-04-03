#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblSectorText_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblSectorText), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onLoad] Entering: [isNull _lblSectorText, isNull _config, _className]: %1"
        , str [isNull _lblSectorText, isNull _config, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblSectorText), _lblSectorText];
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblSectorTextConfig), _config];

[_lblSectorText] call MFUNC2(Sector,_ctrlsGrpSector_lblSectorText_onRefresh);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onLoad] Fini: [ctrlIDC _lblSectorText]: %1"
        , str [ctrlIDC _lblSectorText]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
