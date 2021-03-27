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
