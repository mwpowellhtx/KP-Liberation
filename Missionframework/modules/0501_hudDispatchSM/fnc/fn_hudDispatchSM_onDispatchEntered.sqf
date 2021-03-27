#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/setVariable#Alternative_Syntax

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
    [format ["[fn_hudDispatchSM_onDispatchEntered] Entering: [isNull _player]: %1"
        , str [isNull _player]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
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

// When the REPORT has changed then relay to client
if (!(_standbyReport isEqualTo _dispatchReport)) then {
    // Set the REPORT first then the STATUS since the client SM will key on the STATUS
    _player setVariable [MVAR(_dispatchReport), _standbyReport, _cid];
    _player setVariable [MVAR(_dispatchStatus), _standbyStatus, _cid];
};

// Reset to STANDBY STATUS once DISPATCH fini, await next STANDBY REPORT
_player setVariable [MVAR(_standbyStatus), _standby];
//                        ^^^^^^^^^^^^^^

if (_debug) then {
    [format ["[fn_hudDispatchSM_onDispatchEntered] Fini: [_cid, _standbyStatus, _standbyReport, _dispatchStatus, _dispatchReport]: %1"
        , str [_cid, _standbyStatus, _standbyReport, _dispatchStatus, _dispatchReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
