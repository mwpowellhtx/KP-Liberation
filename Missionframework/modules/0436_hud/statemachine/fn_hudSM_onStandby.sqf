#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onStandby

    File: fn_hudSM_onStandby.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:10:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        STANDBY 'onState' event handler.

    Parameters:
        _player - player for whom STANDBY state is running [OBJECT, default: objNull]

    Returns:
        The event handler has fnished [BOOL]
 */

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
    ["[fn_hudSM_onStandby] Entering...", "HUDSM", true] call KPLIB_fnc_common_log;
};

// Sniff for status bits, we will use to inform what we expect for status report
[
    { [_player, getPos _x] call KPLIB_fnc_hud_inRange; } count KPLIB_fobs_allBuildings
    , { [_player, _x] call KPLIB_fnc_hud_sectorInRange; } count KPLIB_sectors_all
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
    [format ["[fn_hudSM_onStandby] Evaluating: [_fobCount, _sectorCount]: %1"
        , str [_fobCount, _sectorCount]], "HUDSM", true] call KPLIB_fnc_common_log;
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
    [format ["[fn_hudSM_onStandby] Fini: [_standbyStatus]: %1"
        , str [_standbyStatus]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
