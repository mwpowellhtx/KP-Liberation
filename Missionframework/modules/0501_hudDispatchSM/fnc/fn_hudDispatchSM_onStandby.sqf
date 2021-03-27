#include "script_component.hpp"

// Refresh the PLAYER DISPATCH TIMER and offer a hint of the STATUS only

private _debug = [
    [
        {MPARAM(_onStandby_debug)}
    ]
] call MFUNC(_debug);

// ...
// https://community.bistudio.com/wiki/setVariable#Alternative_Syntax

params [
    [Q(_player), objNull, [objNull]]
];

// Sniff for status bits, we will use to inform what we expect for status report
[
    { [_player, (_x#4)] call KPLIB_fnc_hud_inRange; } count KPLIB_sectors_fobs
    , { [_player, _x] call KPLIB_fnc_hud_sectorInRange } count KPLIB_sectors_all
    , KPLIB_hud_status_fob
    , KPLIB_hud_status_sector
    , MVAR(_standbyStatus)
] params [
    Q(_fobCount)
    , Q(_sectorCount)
    , Q(_fob)
    , Q(_sector)
    , Q(_standbyStatus)
];

// Just SET or UNSET the STATUS bits that we might expect from a STATUS REPORT
[_player, _fob, { _fobCount > 0; }, _standbyStatus] call KPLIB_fnc_hud_setPlayerStatus;
[_player, _fob, { _fobCount == 0; }, _standbyStatus] call KPLIB_fnc_hud_unsetPlayerStatus;

[_player, _sector, { _sectorCount > 0; }, _standbyStatus] call KPLIB_fnc_hud_setPlayerStatus;
[_player, _sector, { _sectorCount == 0; }, _standbyStatus] call KPLIB_fnc_hud_unsetPlayerStatus;

/* Refresh the PLAYER DISPATCH TIMER with every STANDBY iteration. It is expected to keep on
 * refreshing the timer until such time as there is a STATUS to REPORT, so that we DISPATCH
 * to the client ASAP when there is anything to report. */

[_player] call KPLIB_fnc_hud_onRefreshPlayerTimer;

true;
