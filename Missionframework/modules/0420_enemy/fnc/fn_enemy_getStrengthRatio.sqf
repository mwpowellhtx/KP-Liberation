#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_getStrengthRatio

    File: fn_enemy_getStrengthRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-18 23:42:16
    Last Update: 2021-04-18 23:42:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the ENEMY STRENGTH expressed in terms of a RATIO of its current value
        over MAX STRENGTH. May apply a single SCALAR, or zero or more ARRAY, BIAS to
        the result.

    Parameter(s):
        _bias - optional bias that may be applied to the ratio result;
            may be either single SCALAR;
            or zero or more ARRAY [SCALAR|ARRAY, default: 0]

    Returns:
        Ratio of ENEMY STRENGTH over MAX STRENGTH [SCALAR|ARRAY]
 */

private _debug = MPARAM(_getStrengthRatio_debug);

params [
    [Q(_bias), 0, [0, []]]
];

[
    MVAR(_strength)
    , MPARAM(_maxStrength)
] params [
    Q(_strength)
    , Q(_maxStrength)
];

private _strengthRatio = _strength / _maxStrength;

if (_bias isEqualType []) exitWith {
    private _biases = _bias;
    _biases apply { _strengthRatio - _x; };
};

_strengthRatio - _bias;
