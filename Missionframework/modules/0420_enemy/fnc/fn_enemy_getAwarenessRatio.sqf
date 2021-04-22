#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_getAwarenessRatio

    File: fn_enemy_getAwarenessRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-18 23:47:11
    Last Update: 2021-04-18 23:47:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the ENEMY AWARENESS expressed in terms of a RATIO of its current value
        over MAX AWARENESS. May apply a single SCALAR, or zero or more ARRAY, BIAS to
        the result.

    Parameter(s):
        _bias - optional bias that may be applied to the ratio result;
            may be either single SCALAR;
            or zero or more ARRAY [SCALAR|ARRAY, default: 0]

    Returns:
        Ratio of ENEMY AWARENESS over MAX AWARENESS [SCALAR]
 */

private _debug = MPARAM(_getAwarenessRatio_debug);

params [
    [Q(_bias), 0, [0, []]]
];

[
    MVAR(_awareness)
    , MPARAM(_maxAwareness)
] params [
    Q(_awareness)
    , Q(_maxAwareness)
];

private _awarenessRatio = _awareness / _maxAwareness;

if (_bias isEqualType []) exitWith {
    private _biases = _bias;
    _biases apply { _awarenessRatio - _x; };
};

_awarenessRatio - _bias;
