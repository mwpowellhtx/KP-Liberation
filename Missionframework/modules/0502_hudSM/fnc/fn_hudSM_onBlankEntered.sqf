#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onBlankEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudSM_onBlankEntered] Entering...", "HUDSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: if we are here then there is either NO STATUS REPORT
// TODO: TBD: or a dialog has opened, in either event, BLANK the HUD

[_player, KPLIB_hud_overlayBlank] call KPLIB_fnc_hud_onStatusReport;

// // Seems to work okay... see: overlay notes
// systemChat format ["[fn_hudSM_onBlankEntered]: [KPLIB_hud_overlayBlank]: %1"
//     , str [KPLIB_hud_overlayBlank]];

if (_debug) then {
    [format ["[fn_hudSM_onBlankEntered] Fini: [KPLIB_hud_overlayBlank]: %1"
        , str [KPLIB_hud_overlayBlank]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
