/*
    KPLIB_fnc_core_getNearestMarker

    File: fn_core_getNearestMarker.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-11-26
    Last Update: 2021-04-23 18:46:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the NEAREST MARKER within RANGE of the TARGET POSTIION.

    Parameter(s):
        _range - range about which to search for sectors [SCALAR, default: KPLIB_param_sectors_actRange]
        _targetPos - target position from where to start searching for markers [POSITION, default: getPos player]
        _markers - array of markers to check [ARRAY, default: KPLIB_sectors_all]

    Returns:
        The NEAREST MARKER or EMPTY STRING [STRING]
 */

params [
    ["_range", KPLIB_param_sectors_actRange, [0]]
    , ["_targetPos", getPos player, [[]], 3]
    , ["_markers", KPLIB_sectors_all, [[]]]
];

private _getDistance = { (markerPos _this) distance2D _targetPos; };

private _selection =  _markers select { (_x call _getDistance) <= _range; };

private _sorted = [_selection, [], { _x call _getDistance; }, "ASCEND"] call BIS_fnc_sortBy;

if (_sorted isEqualTo []) exitWith { ""; };

(_sorted#0);
