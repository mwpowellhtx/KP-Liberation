#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_grpBase_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_grpBase), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_grpBase_onLoad] Entering: [isNull _grpBase, isNull _config]: %1"
        , str [isNull _grpBase, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// ...

if (_debug) then {
    ["[fn_hud_grpBase_onLoad] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
