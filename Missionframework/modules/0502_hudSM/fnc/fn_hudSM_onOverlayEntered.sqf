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

// TODO: TBD: we are here because we want to cut out the blank and cut in the overlay
// TODO: TBD: then we must decide which FOB +/- SECTOR groups to make visible

private _status = _player getVariable [KPLIB_hudDispatchSM_dispatchStatus, KPLIB_hud_status_standby];
private _report = _player getVariable [KPLIB_hudDispatchSM_dispatchReport, []];

systemChat format ["[fn_hudSM_onOverlayEntered] Entering: [_status, count _report]: %1"
    , str [_status, count _report]];

true;
