/*
    KPLIB_fnc_common_getNearestSpawnPositions

    File: fn_common_getNearestSpawnPositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 13:40:02
    Last Update: 2021-05-04 12:44:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the nearest positions assuming nearby BUILDINGS, including TARGET POSITION.

    Parameter(s):
        _targetPos - a target position [POSITION, default: _defaultTargetPos]
        _range - a range about which to locate [SCALAR, default: 0]
        _vectorOffset - a vector offset [ARRAY, default: _defaultTargetPos]

    Returns:
        An array of the nearest spawn positions [ARRAY]
 */

private _defaultTargetPos = +KPLIB_zeroPos;
private _defaultTargetPos = [0, 0, 0.5];

params [
    ["_targetPos", _defaultTargetPos, [[]], 3]
    , ["_range", 0, [0]]
    , ["_vectorOffset", _defaultVectorOffset, [[]], 3]
];

private _buildings = [_targetPos, _range] call KPLIB_fnc_common_getNearestSpawnBuildings;

private _positions = [[], _buildings apply { _x buildingPos -1; }] call KPLIB_fnc_linq_aggregate;

private _sorted = [_positions, [], { _x distance2D _targetPos; }] call BIS_fnc_sortBy;

private _retval = _sorted apply { _x vectorAdd _vectorOffset; };

_retval;
