#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/setVariable#Alternative_Syntax

params [
    [Q(_player), objNull, [objNull]]
];

if (isNull _player) exitWith {
    false;
};

// TODO: TBD: roll up a fresh status report and determine what the next STATUS should be...

private _standby = KPLIB_hud_status_standby;

// Identify whether the PLAYER DISPATCH TIMER has elapsed
private _elapsed = [] call {

    [
        [MPARAM(_dispatchPeriod)] call KPLIB_fnc_timers_create
        , _player getVariable [QMVAR(_dispatchTimer), +KPLIB_timers_default]
    ] params [
        Q(_defaultTimer)
        , Q(_timer)
    ];

    private _elapsed = _timer call KPLIB_fnc_timers_hasElapsed;

    // (Re-)set the timer when it has elapsed
    if (_elapsed) then {
        _player setVariable [QMVAR(_dispatchTimer), _defaultTimer];
    };

    _elapsed;
};

// Exit early when DISPATCH TIMER has NOT ELAPSED
if (!_elapsed) exitWith {
    false;
};

/* Remember, '_standbyStatus' and '_standbyReport' are local to server,
 * whereas DISPATCH copies of the same are relayed to the player
 */
[
    owner _player
    , _player getVariable [QMVAR(_standbyStatus), _standby]
    , _player getVariable [QMVAR(_dispatchStatus), _standby]
    , _player getVariable [QMVAR(_standbyReport), []]
    , _player getVariable [QMVAR(_dispatchReport), []]
] params [
    Q(_cid)
    , Q(_standbyStatus)
    , Q(_dispatchStatus)
    , Q(_standbyReport)
    , Q(_dispatchReport)
];

// When the REPORT has changed then relay to client
if (!(_standbyReport isEqualTo _dispatchReport)) then {
    // Set the REPORT first then the STATUS since the client SM will key on the STATUS
    _player setVariable [QMVAR(_dispatchReport), _standbyReport, _cid];
    _player setVariable [QMVAR(_dispatchStatus), _standbyStatus, _cid];
};

// Dispatch complete, reset the STANDBY STATUS, awaiting the next REPORT
_player setVariable [QMVAR(_standbyStatus), _standby];
//                         ^^^^^^^^^^^^^^

true;
