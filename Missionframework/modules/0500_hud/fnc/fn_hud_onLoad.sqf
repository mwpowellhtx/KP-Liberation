#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload

private _debug = [
    [
        {MPARAM(_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_display), displayNull, [displayNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_onLoad] Entering: [isNull _display, isNull _config]"
        , str [isNull _display, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: in the event we need to register anything, in the uiNamespace, etc...

// Lift the CLASS NAME back from the DISPLAY instance itself
_display setVariable [QMVAR(_className), (configName _config)];
private _className = _display getVariable [QMVAR(_className), ""];

if (_debug) then {
    // Worked around a config issue
    systemChat format ["[fn_hud_onLoad] [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]];
};

// Set the DISPLAY and CONFIG in the appropriate namespace for later bookkeeping
{ uiNamespace setVariable _x; } forEach [
    [QMVAR(_display), _display]
    , [QMVAR(_config), _config]
    , [QMVAR(_className), _className]
];

if (_debug) then {
    [format ["[fn_hud_onLoad] Fini: [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
