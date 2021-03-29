#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_lblMarkerText_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblMarkerText), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_lblMarkerText_onLoad] Entering: [isNull _lblMarkerText, isNull _config]: %1"
        , str [isNull _lblMarkerText, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// With the benefit of doing baseline 'onLoad' handling
[_lblMarkerText, _config] call MFUNC(_ctrlBase_onLoad);

// ...

if (_debug) then {
    ["[fn_hud_lblMarkerText_onLoad] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
