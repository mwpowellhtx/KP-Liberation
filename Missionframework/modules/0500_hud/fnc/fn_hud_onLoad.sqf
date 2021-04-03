#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
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
    [format ["[fn_hud_onLoad] Entering: [isNull _display, isNull _config]: %1"
        , str [isNull _display, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: in the event we need to register anything, in the uiNamespace, etc...

// Lift the CLASS NAME back from the DISPLAY instance itself
_display setVariable [QMVAR(_className), (configName _config)];
private _className = _display getVariable [QMVAR(_className), ""];

// TODO: TBD: may need to separate SECTOR from FOB overlays...
// Clear off FOB, SECTOR and SHADOW elements when BLANK
if (toLower _className find MVAR(_action_blank) > 0) then {
    { uiNamespace setVariable [_x, nil]; } forEach [
        QMVAR(_lnbFob)
        , QMVAR(_lnbFobShadow)
    ];
    true;
};

if (_debug) then {

    systemChat format ["[fn_hud_onLoad] [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]];

    [format ["[fn_hud_onLoad] Fini: [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
