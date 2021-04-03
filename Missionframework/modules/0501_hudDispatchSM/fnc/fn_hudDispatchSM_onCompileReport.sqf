#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onCompileReport

    File: fn_hudDispatchSM_onCompileReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Compiles the DISPATCH REPORT for the given player.

    Parameters:
        _player - player for whom DISPATCH REPORT is being compiled [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/setVariable#Alternative_Syntax
 */

private _debug = [
    [
        {MPARAM(_onCompileReport_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudDispatchSM_onCompileReport] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Create the PLAYER centric REPORT CONTEXT and raise the REPORT EVENTS
private _context = [_player] call MFUNC(_createReportContext);

// TODO: TBD: trying this way instead, a 'simple' array of REPORT callbacks
{
    if (_debug) then {
        [format ["[fn_hudDispatchSM_onCompileReport::forEach] Report callback: [owner _player, _forEachIndex]: %1"
            , str [owner _player, _forEachIndex]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
    };
    [_player, _context] call _x;
} forEach (MVAR(_reportFob_callbacks) + MVAR(_reportSector_callbacks));

// // Even though this should already be on SERVER, make sure it is
// [[MVAR(_reportFob), MVAR(_reportSector)], [_player, _context]] call {
//     params [
//         [Q(_eventNames), [], [[]]]
//         , [Q(_args), [], [[]]]
//     ];
//     {
//         private _eventName = _x;
//         [_x, _args] call CBA_fnc_serverEvent;
//     } forEach _eventNames;
// };

[
    _context getVariable [Q(_compiledReport), []]
] params [
    Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCompileReport] Evaluating: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

[
    { [(_x#0), MVAR(_fobReportPrefix)] call KPLIB_fnc_string_startsWith; } count _compiledReport
    , { [(_x#0), MVAR(_sectorReportPrefix)] call KPLIB_fnc_string_startsWith; } count _compiledReport
    , KPLIB_hud_status_noReport
    , KPLIB_hud_status_fob
    , KPLIB_hud_status_sector
] params [
    Q(_fobReportCount)
    , Q(_sectorReportCount)
    , Q(_noReport)
    , Q(_fob)
    , Q(_sector)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCompileReport] Status: [_fobReportCount, _sectorReportCount]: %1"
        , str [_fobReportCount, _sectorReportCount]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Twiddle COMPILED STATUS, remember to capture after invoking
private _compiledStatus = KPLIB_hud_status_standby;

// Looks very similar to the STANDBY SNIFF, make it official with a REPRRT COUNT
_compiledStatus = [_compiledStatus, _fob, { _fobReportCount > 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_compiledStatus = [_compiledStatus, _fob, { _fobReportCount == 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

_compiledStatus = [_compiledStatus, _sector, { _sectorReportCount > 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_compiledStatus = [_compiledStatus, _sector, { _sectorReportCount == 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

// Echoing the fact, NO REPORT is still a report, so flag it accordingly
_compiledStatus = [_compiledStatus, _noReport, { (_fobReportCount + _sectorReportCount) == 0; }] call KPLIB_fnc_hud_setPlayerStatus;
_compiledStatus = [_compiledStatus, _noReport, { (_fobReportCount + _sectorReportCount) > 0; }] call KPLIB_fnc_hud_unsetPlayerStatus;

// Then relay the bits for DISPATCH consideration
{ _player setVariable _x; } forEach [
    [QMVAR(_standbyReport), _compiledReport]
    , [QMVAR(_standbyStatus), _compiledStatus]
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCompileReport] Fini: [_compiledStatus, count _standbyReport]: %1"
        , str [_compiledStatus, count _standbyReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Safe to GC the CONTEXT now
[_context] call KPLIB_fnc_namespace_onGC;

true;
