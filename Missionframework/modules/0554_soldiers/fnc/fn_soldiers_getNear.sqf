#include "script_component.hpp"
/*
    KPLIB_fnc_soldiers_getNear

    File: fn_soldiers_getNear.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 14:04:57
    Last Update: 2021-04-11 13:04:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the units that are near the POSITION. May specify a PREDICATE
        to further filter the selection beyond SIDE alignments.

    Parameter(s):
        _pos - a POSITION about which to check for units [POSITION, defaults: KPLIB_zeroPos]
        _range - range in meters [SCALAR, default: KPLIB_param_sectors_actRange]
        _sides - array of SIDE values [ARRAY, default: [KPLIB_preset_sideF]]
        _predicate - a further predicate to filter the actual selection [CODE, default: { true; }]

    Returns:
        An array of the units near the POSITION [ARRAY]
 */

private _defaultPredicate = { !(isNull _this) && (alive _this); };

params [
    [Q(_pos), KPLIB_zeroPos, [[]], [2, 3]]
    , [Q(_range), KPLIB_param_sectors_actRange, [0]]
    , [Q(_sides), [KPLIB_preset_sideF], [[]]]
    , [Q(_predicate), { true; }, [{}]]
];

if (_pos isEqualTo KPLIB_zeroPos) exitWith { []; };

private _candidates = _pos nearEntities ["AllVehicles", _range];

_candidates select {
    private _predicated = _x call _predicate;
    private _defaultPredicated = _x call _defaultPredicate;
    private _side = side _x;
    private _aligned = _side in _sides;
    _predicated && _defaultPredicated && _aligned;
};
