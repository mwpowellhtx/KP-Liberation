#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onCapturing

    File: fn_sectorsSM_onCapturing.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 20:48:40
    Last Update: 2021-04-21 20:48:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Only ever appends potentially ACTIVATING SECTORS to the existing set of ACTIVE SECTORS.
        At most 'KPLIB_param_sectors_maxAct' sectors may be active at any one time.

        We are here because the SECTOR is in a CAPTURING condition. When the corresponding
        TIMER has elapsed, then we may consider the SECTOR CAPTURED to the appropriate side.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onCapturing_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_timer), []]
    , [_namespace, MSTATUS(_captured), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus
    , [_namespace, MSTATUS(_capturing), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_markerName)
    , Q(_timer)
    , Q(_captured)
    , Q(_capturing)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturing] Entering: [_markerName, _timer, _captured, _capturing]: %1"
        , str [_markerName, _timer, _captured, _capturing]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

private _actuallyCaptured = _capturing && !_captured;

// TODO: TBD: first disembark crews from vehicles and so forth...
// TODO: TBD: then identify units that may surrender...
// TODO: TBD: also decide whether should do any of that one-unit/asset per state machine iteration...
[_namespace, MSTATUS(_captured), { _actuallyCaptured; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
[_namespace, MSTATUS(_captured), { !_capturing; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

if (_actuallyCaptured) then {
    [MVAR(_captured), [_namespace]] call CBA_fnc_serverEvent;
};

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturing] Fini: [_markerName, _timer, _capturing, _captured]: %1"
        , str [_markerName, _timer, _capturing, _captured]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
