/*
    KPLIB_fnc_common_getNearestSpawnBuildings

    File: fn_common_getNearestSpawnBuildings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 16:47:18
    Last Update: 2021-05-04 12:44:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the nearest BUILDINGS which support at least ONE position.

    Parameter(s):
        _targetPos - a target position [POSITION, default: _defaultTargetPos]
        _range - a range about which to locate [SCALAR, default: 0]

    Returns:
        An array of the nearest spawn positions [ARRAY]
 */

private _defaultTargetPos = +KPLIB_zeroPos;
private _defaultTargetPos = [0, 0, 0.5];

params [
    ["_targetPos", _defaultTargetPos, [[]], 3]
    , ["_range", 0, [0]]
];

private _buildings = nearestObjects [_targetPos, ["Building"], _range];

private _retval = _buildings select { count (_x buildingPos -1) > 0; };

_retval;
