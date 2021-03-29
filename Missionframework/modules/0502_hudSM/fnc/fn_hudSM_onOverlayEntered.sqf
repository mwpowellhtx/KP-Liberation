#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onOverlayEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudSM_onOverlayEntered] Entering...", "HUDSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: we are here because we want to cut out the blank and cut in the overlay
// TODO: TBD: then we must decide which FOB +/- SECTOR groups to make visible

[
    _player getVariable [QMVAR(_overlayStatus), KPLIB_hud_status_standby]
    , _player getVariable [QMVAR(_overlayReport), []]
] params [
    Q(_overlayStatus)
    , Q(_overlayReport)
];

// // Seems to work okay from "on site" to "no report", i.e. FOB+SECTOR versus NOREPORT
// systemChat format ["[fn_hudSM_onOverlayEntered]: [KPLIB_hud_action_overlayReport, _overlayStatus, count _overlayReport]: %1"
//     , str [KPLIB_hud_action_overlayReport, _overlayStatus, count _overlayReport]];

[_player, KPLIB_hud_action_overlayReport, _overlayReport] call KPLIB_fnc_hud_onStatusReport;

if (_debug) then {
    [format ["[fn_hudSM_onOverlayEntered] Fini: [KPLIB_hud_action_overlayReport, count _overlayReport]: %1"
        , str [KPLIB_hud_action_overlayReport, count _overlayReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
