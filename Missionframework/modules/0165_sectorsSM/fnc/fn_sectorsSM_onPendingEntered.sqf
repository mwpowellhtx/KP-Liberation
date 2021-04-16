#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onPendingEntered

    File: fn_sectorsSM_onPendingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-04-14 00:01:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onPendingEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (isServer) then {
    [format ["[fn_sectorsSM_onPendingEntered] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// Ensures that a default timer is properly installed
if ([_namespace, MSTATUS(_garrisoned), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus) then {
    // We do not care about ELAPSED apart from installing the TIMER
    [_namespace, QMVAR(_timer), [MPARAM(_pendingPeriod)] call KPLIB_fnc_timers_create] call KPLIB_fnc_namespace_timerHasElapsed;
};

// TODO: TBD: fill in the gaps...

if (isServer) then {
    [format ["[fn_sectorsSM_onPendingEntered] Fini: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
