#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_findSafePosition

    File: fn_garrison_findSafePosition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-05 08:52:21
    Last Update: 2021-06-14 17:13:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the SAFE POSITION given a reference POSITION and RANGE.

    Parameter(s):
        _pos - a reference POSITION about which to FIND [POSITION, default: KPLIB_zeroPos]
        _range - a RANGE about which to FIND [SCALAR, default: KPLIB_param_sectors_capRange]

    Returns:
        A safe position given the inputs [POSITION]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_findSafePos
 */

params [
    [Q(_pos), +KPLIB_zeroPos, [[]]]
    , [Q(_range), KPLIB_param_sectors_capRange, [0]]
];

if (_debug) then {
    // TODO: TBD: logging
};

private _safePos = [_pos, _range, _range + random _range, 0, 0.15] call BIS_fnc_findSafePos;

if (_debug) then {
    // TODO: TBD: logging
};

_safePos;

