#include "script_component.hpp"
/*
    KPLIB_fnc_soldiers_checkNear

    File: fn_soldiers_checkNear.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 14:04:57
    Last Update: 2021-04-06 14:04:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Checks whether units are near the POSITION. May specify a PREDICATE
        to further filter the selection beyond SIDE alignments.

    Parameter(s):
        _pos - a POSITION about which to check for units [POSITION, defaults: KPLIB_zeroPos]
        _range - range in meters [SCALAR, default: KPLIB_param_sectors_actRange]
        _sides - array of SIDE values [ARRAY, default: [KPLIB_preset_sideF]]
        _predicate - a further predicate to filter the actual selection [CODE, default: _defaultPredicate]

    Returns:
        Whether units are near [BOOL]
 */

private _defaultPredicate = { !(isNull _this) && (alive _this); };

params [
    [Q(_pos), KPLIB_zeroPos, [[]], [2, 3]]
    , [Q(_range), KPLIB_param_sectors_actRange, [0]]
    , [Q(_sides), [KPLIB_preset_sideF], [[]]]
    , [Q(_predicate), _defaultPredicate, [{}]]
];

private _candidates = [_pos, _range, _sides, _predicate] call MFUNC(_getNear);

!(_candidates isEqualTo []);
