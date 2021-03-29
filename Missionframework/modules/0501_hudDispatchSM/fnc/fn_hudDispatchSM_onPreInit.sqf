#include "script_component.hpp"

// ...

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initializing...", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Setup DISPATCH settings
[] call MFUNC(_settings);

MVAR(_dispatchStatus)                   = QMVAR(_dispatchStatus);
MVAR(_dispatchReport)                   = QMVAR(_dispatchReport);

MVAR(_fobReportPrefix)                  = QMVAR(_fobReport);
MVAR(_sectorReportPrefix)               = QMVAR(_sectorReport);

// This is defined both client and server because it serves as HUD function argument defaults
MVAR(_dispatchTimer)                    = QMVAR(_dispatchTimer);

if (isServer) then {
    // Server side init

    // TODO: TBD: this is a placeholder...
    // TODO: TBD: really deserves its own module dedicated to the problem of civilian reputation
    // TODO: TBD: but for purposes of HUD, we will pencil it in here, for now...
    // TODO: TBD: while we are there we also need to define some limits, threhsolds, etc
    KPLIB_civilian_civRep               =    0;
    // TODO: TBD: will also need to slot that in for persistence load/save...
    KPLIB_param_civilian_maxCivRep      = 1000;
    // TODO: TBD: we double it, and triple it, depending on the circumstance, and desired game effect...
    // TODO: TBD: therefore, should be bounded to something like 30-33 ...
    KPLIB_civilian_civRepBaseThreshold  = 0.25;
    KPLIB_civilian_killedPenalty        =    0;

    MPRESET(_enemy_low)                 = 0.25;
    MPRESET(_enemy_medium)              = 0.65;
    MPRESET(_enemy_high)                = 0.85;

    MVAR(_className)                    = Q(KPLIB_hudDispatchSM);

    MVAR(_objSM)                        = locationNull;
    MVAR(_configSM)                     = configNull;

    // For use with stackable player connected/disconnected events
    MVAR(_playerConnected)              = Q(PlayerConnected);
    MVAR(_playerDisconnected)           = Q(PlayerDisconnected);

    MVAR(_standbyStatus)                = QMVAR(_standbyStatus);
    MVAR(_standbyReport)                = QMVAR(_standbyReport);

    MVAR(_reportFob)                    = QMVAR(_reportFob);
    MVAR(_reportSector)                 = QMVAR(_reportSector);
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initialized", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
