#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_getUnits

    File: fn_hudSM_getUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:06:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the side units within range of the given position.

    Parameters:
        _pos - position at which to obtain units [ARRAY, default: KPLIB_zeroPos]
        _side - the side for which units must align [SIDE, default: KPLIB_preset_sideF]
        _range - the range about which units must be within [SCALAR, default: KPLIB_param_fobRange]

    Returns:
        The units corresponding to the side and within range [ARRAY]
 */

params [
    [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_side), KPLIB_preset_sideF, [KPLIB_preset_sideF]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

private _units = nearestObjects [_pos, [Q(CAManBase)], _range];

// Select ALIVE units that are ALIGNED
_units select {
    alive _x
        && side _x == _side;
};
