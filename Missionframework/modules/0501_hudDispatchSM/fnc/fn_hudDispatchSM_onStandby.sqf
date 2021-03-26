#include "script_component.hpp"

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

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Entering: [isNull _player]: %1"
        , str [isNull _player]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (isNull _player) exitWith {
    false;
};

// TODO: TBD: then it is a matter of connecting HUD report and status with the player
[
    [_player] call MFUNC(_onReportFob)
    , [_player] call MFUNC(_onReportSector)
    , KPLIB_hud_status_standby
    , []
] params [
    Q(_fobReport)
    , Q(_sectorReport)
    , Q(_status)
    , Q(_allReports)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Compiling reports: [count _fobReport, count _sectorReport]: %1"
        , str [count _fobReport, count _sectorReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

{
    _x params [
        [Q(_reportName), "", [""]]
        , [Q(_report), [], [[]]]
        , [Q(_reportStatus), KPLIB_hud_status_standby, [0]]
        , [Q(_awayReportStatus), KPLIB_hud_status_standby, [0]]
    ];

    // When there is "no report" meaning "away report status
    if (_report isEqualTo []) then {
        _status = [_status, _awayReportStatus] call KPLIB_fnc_hud_setPlayerStatus;
    } else {
        _allReports append _report;
        _status = [_status, _reportStatus] call KPLIB_fnc_hud_setPlayerStatus;
    };

} forEach [
    [Q(_fobReport), _fobReport, KPLIB_hud_status_fob, KPLIB_hud_status_awayFob]
    , [Q(_sectorReport), _sectorReport, KPLIB_hud_status_sector, KPLIB_hud_status_awaySector]
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Setting: [_status, count _allReports]: %1"
        , str [_status, count _allReports]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

/* Remember:
 *      1. PLAYER is server side
 *      2. We also do not want to confuse public/shared variables across the wire
 * So we must stage with 'local' scope PLAYER variables for DISPATCH consideration
 */
_player setVariable [QMVAR(_standbyStatus), _status];
//                         ^^^^^^^^^^^^^^
_player setVariable [QMVAR(_standbyReport), _allReports];
//                         ^^^^^^^^^^^^^^

if (_debug) then {
    [format ["[fn_hudDispatchSM_onStandby] Fini: [_status, _allReports]: %1"
        , str [_status, _allReports]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
