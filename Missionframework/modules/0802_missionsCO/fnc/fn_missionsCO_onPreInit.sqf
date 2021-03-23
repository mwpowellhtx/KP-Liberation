#include "script_component.hpp"
/*
    KPLIB_fnc_missionsCO_onPreInit

    File: fn_missionsCO_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2021-03-22 09:58:10
    Last Update: 2021-03-22 09:58:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["Initializing...", "PRE] [MISSIONSCO", true] call KPLIB_fnc_common_log;
};

// The "request" event name and arguments
MVAR(_request)                                  = QMVAR(_request);
MVAR(_requestRun)                               = Q(run);
MVAR(_requestAbort)                             = Q(abort);

if (isServer) then {
    // Server side init
    MPARAM(_debug)                              = true;
    MPARAM(_onRequest_debug)                    = true;
};

if (hasInterface) then {
    // Client side init
};

if (isServer) then {
    ["Initialized", "PRE] [MISSIONSCO", true] call KPLIB_fnc_common_log;
};

true;
