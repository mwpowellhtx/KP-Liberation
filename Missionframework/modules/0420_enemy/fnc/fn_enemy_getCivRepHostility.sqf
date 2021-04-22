#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_getCivRepHostility

    File: fn_enemy_getCivRepHostility.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 08:00:45
    Last Update: 2021-04-19 08:00:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a positive ratio of CIVILIAN REPUTATION in terms of HOSTILITY. What do
        we mean by that? We are only concerned with whether reputation has lapsed into
        negative ranges, but expressed in a positive ratio. May apply a single SCALAR,
        or zero or more ARRAY, BIAS to the result.

    Parameter(s):
        _bias - optional bias that may be applied to the ratio result;
            may be either single SCALAR;
            or zero or more ARRAY [SCALAR|ARRAY, default: 0]

    Returns:
        CIVILIAN REPUTATION in terms of HOSTILITY [SCALAR|ARRAY]
 */

private _debug = MPARAM(_getCivRepHostility_debug);

params [
    [Q(_bias), 0, [0, []]]
];

[
    MVAR(_civRep)
    , MPARAM(_maxCivRep)
] params [
    Q(_civRep)
    , Q(_maxCivRep)
];

// Note that in this case we ONLY want the NEGATIVE range filtered
private _civRepBounded = -_maxCivRep max (_civRep min 0);

private _civRepRatio = (abs _civRepBounded) / _maxCivRep;

if (_bias isEqualType []) exitWith {
    private _biases = _bias;
    _biases apply { _civRepRatio - _x; };
};

_civRepRatio - _bias;
