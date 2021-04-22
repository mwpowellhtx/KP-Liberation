#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningCalculateEachCount

    File: fn_garrison_onGarrisoningCalculateEachCount.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-17 22:50:18
    Last Update: 2021-04-21 11:27:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the GARRISON SPECIFICATION count for a given set of parameters.

    Parameter(s):
        _min - the minimum number of count [SCALAR, default: 0]
        _count - a pseudo-randomized count to use when calculating [SCALAR, default: 0]
        _ceil - apply either CEIL (true) or ROUND (false) [BOOL, default: false]
        _coef - a coefficient to use [SCALAR, default: 1]

    Returns:
        The desired functional primitive [CODE]
 */

private _defaultFilter = { ceil _this; };

params [
    [Q(_min), 0, [0]]
    , [Q(_count), 0, [0]]
    , [Q(_ceil), false, [false]]
    , [Q(_coef), 1, [0]]
];

private _filter = [_ceil] call MFUNC(_onGarrisoningGetFilter);

_coef * (_min + ((random _count) call _filter));
