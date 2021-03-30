//#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_ctFob_ctrl_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_ctrl), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;

if (_debug) then {
    [format ["[fn_hud_ctFob_ctrl_onLoad] Entering: [ctrlIDC _ctrl, _className, isNull _ctrl, isNull _config]: %1"
        , str [ctrlIDC _ctrl, _className, isNull _ctrl, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// ...

if (_debug) then {
    ["[fn_hud_ctFob_ctrl_onLoad] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
