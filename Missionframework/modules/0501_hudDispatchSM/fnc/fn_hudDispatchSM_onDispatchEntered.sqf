#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onDispatchEntered

    File: fn_hudDispatchSM_onDispatchEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        DISPATCH 'onStateEntered' event handler.

    Parameters:
        _player - player for whom DISPATCH state has entered [OBJECT, default: objNull]

    Returns:
        The event handler has fnished [BOOL]

    References:
        https://community.bistudio.com/wiki/setVariable#Alternative_Syntax
 */

private _debug = [
    [
        {MPARAM(_onDispatchEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// TODO: TBD: roll up a fresh status report and determine what the next STATUS should be...

if (_debug) then {
    ["[fn_hudDispatchSM_onDispatchEntered] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// If we are here it is because STANDBY COMPILED a REPORT and kicked STATUS over to DISPATCH
private _standby = KPLIB_hud_status_standby;

/* Remember, '_standbyStatus' and '_standbyReport' are local to server,
 * whereas DISPATCH copies of the same are relayed to the player
 */
[
    owner _player
    , _player getVariable [MVAR(_standbyStatus), _standby]
    , _player getVariable [MVAR(_standbyReport), []]
    , _player getVariable [MVAR(_dispatchStatus), _standby]
    , _player getVariable [MVAR(_dispatchReport), []]
] params [
    Q(_cid)
    , Q(_standbyStatus)
    , Q(_standbyReport)
    , Q(_dispatchStatus)
    , Q(_dispatchReport)
];

// STATUS is too coarse a gauge, so we contrast the REPORT itself
if (!(_standbyReport isEqualTo _dispatchReport)) then {
    // Set the REPORT first then the STATUS since the client SM will key on the STATUS
    { _player setVariable _x; } forEach [
        [MVAR(_dispatchReport), _standbyReport, _cid]
        , [MVAR(_dispatchStatus), _standbyStatus, _cid]
    ];
};

// // // TODO: TBD: leave this one alone between STANDBY iterations
// // Reset to STANDBY STATUS once DISPATCH fini, await next STANDBY REPORT
// _player setVariable [MVAR(_standbyStatus), _standby];
// //                        ^^^^^^^^^^^^^^

if (_debug) then {
    [format ["[fn_hudDispatchSM_onDispatchEntered] Fini: [_cid, _standbyStatus, _dispatchStatus, count _standbyReport, count _dispatchReport]: %1"
        , str [_cid, _standbyStatus, _dispatchStatus, count _standbyReport, count _dispatchReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
