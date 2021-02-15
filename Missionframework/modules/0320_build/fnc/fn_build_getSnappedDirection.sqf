/*
    KPLIB_fnc_build_getSnappedDirection

    File: fn_build_getSnappedDirection.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 19:03:58
    Last Update: 2021-02-14 19:04:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Snaps the '_dir' to the '_snapDegrees' and number of '_places'.

    Parameter(s):
        _dir - the direction to snap [SCALAR, default: 0]
        _snapDegrees - the degrees to which to snap [SCALAR, default: KPLIB_param_build_snapDegrees]
        _places - the places to which to truncate [SCALAR, default: KPLIB_param_build_degreePlaces]

    Returns:
       Object that is currently under the cursor [OBJECT]
 */

params [
    ["_dir", 0, [0]]
    , ["_snapDegrees", KPLIB_param_build_snapDegrees, [0]]
    , ["_places", KPLIB_param_build_degreePlaces, [0]]
];

_dir = (_dir max 0) min 360;

private _retval = if (_snapDegrees isEqualTo 1) then {_dir} else {
    _snapDegrees * floor ((_dir + (_snapDegrees / 2)) / _snapDegrees);
};

private _factor = 10 ^ _places;

floor (_retval * _factor) / _factor;
