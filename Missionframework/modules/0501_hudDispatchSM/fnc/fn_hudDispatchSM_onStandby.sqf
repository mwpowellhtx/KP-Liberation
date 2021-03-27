#include "script_component.hpp"

// Refresh the PLAYER DISPATCH TIMER and offer a hint of the STATUS only
// ...
// https://community.bistudio.com/wiki/setVariable#Alternative_Syntax

private _debug = [
    [
        {MPARAM(_onStandby_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudDispatchSM_onStandby] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Sniff for status bits, we will use to inform what we expect for status report
[
    { [_player, (_x#4)] call KPLIB_fnc_hud_inRange; } count KPLIB_sectors_fobs
    , { [_player, _x] call KPLIB_fnc_hud_sectorInRange } count KPLIB_sectors_all
    , KPLIB_hud_status_noReport
    , KPLIB_hud_status_fob
    , KPLIB_hud_status_sector
] params [
    Q(_fobCount)
    , Q(_sectorCount)
    , Q(_noReport)
    , Q(_fob)
    , Q(_sector)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Evaluating: [_fobCount, _sectorCount]: %1"
        , str [_fobCount, _sectorCount]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Lift PLAYER STATUS, twiddle, and replace
private _standbyStatus = _player getVariable [QMVAR(_standbyStatus), KPLIB_hud_status_standby];

// Just SET or UNSET the STATUS bits that we might expect from a STATUS REPORT
_standbyStatus = [_standbyStatus, _fob, { _fobCount > 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_standbyStatus = [_standbyStatus, _fob, { _fobCount == 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

_standbyStatus = [_standbyStatus, _sector, { _sectorCount > 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_standbyStatus = [_standbyStatus, _sector, { _sectorCount == 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

// NO REPORT is still a report, so set that flag accordingly
_standbyStatus = [_standbyStatus, _noReport, { (_fobCount + _sectorCount) == 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_standbyStatus = [_standbyStatus, _noReport, { (_fobCount + _sectorCount) > 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

_player setVariable [QMVAR(_standbyStatus), _standbyStatus];

/* Refresh the PLAYER DISPATCH TIMER with every STANDBY iteration. It is expected to keep on
 * refreshing the timer until such time as there is a STATUS to REPORT, so that we DISPATCH
 * to the client ASAP when there is anything to report. */

[_player] call KPLIB_fnc_hud_onRefreshPlayerTimer;

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Fini: [_standbyStatus]: %1"
        , str [_standbyStatus]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
