#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_getStochasticTrigger

    File: fn_sectorsSM_getStochasticTrigger.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-13 14:36:49
    Last Update: 2021-04-13 14:36:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a pseudo-random stochastic trigger. Default stochasticity is derived in
        terms of ENEMY AWARENESS, but the threshold and maximum values may be derived
        based on anything.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _threshold - a threshold against which to trigger [SCALAR, default: KPLIB_enemy_awareness]
        _max - a maximum used to inform the next pseudo-random value [SCALAR, default: KPLIB_param_enemy_maxAwareness]
        _arity - delta threshold adjustment considering how frequent [SCALAR, default: KPLIB_sectors_missionArity_common]

    Returns:
        A pseudo-random stochastic trigger [BOOL]

    References:
        https://community.bistudio.com/wiki/random
 */

private _debug = MPARAMSM(_getStochasticTrigger_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_threshold), KPLIB_enemy_awareness, [0]]
    , [Q(_max), KPLIB_param_enemy_maxAwareness, [0]]
    , [Q(_arity), MPRESET(_arity_zero), [0]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_getStochasticTrigger] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

private _retval = (random _max) call { _this <= (_threshold - _arity); };

if (_debug) then {
    [format ["[fn_sectorsSM_getStochasticTrigger] Fini: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

_retval;
