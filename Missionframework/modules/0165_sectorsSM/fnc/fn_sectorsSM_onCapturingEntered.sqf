#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onCapturingEntered

    File: fn_sectorsSM_onCapturingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-08 23:19:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Only ever appends potentially ACTIVATING SECTORS to the existing set of ACTIVE SECTORS.
        At most 'KPLIB_param_sectors_maxAct' sectors may be active at any one time.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onCapturingEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturing] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// [_namespace, MSTATUS(_deactivated), { _timer call KPLIB_fnc_timers_hasElapsed; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

_namespace setVariable [QMVAR(_timer), nil];

if (_debug) then {
    ["[fn_sectorsSM_onCapturing] Fini", "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
