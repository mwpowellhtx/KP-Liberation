/*
    KPLIB_fnc_common_calculateRadialPositions

    File: fn_common_calculateRadialPositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-03 11:57:03
    Last Update: 2021-05-03 11:57:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the calculated radial positions.

    Parameter(s):
        _centerPos - the center position about which to calculate [POSITION, default: KPLIB_zeroPos]
        _range - the range informing the radial positions [SCALAR, default: 0]
        _div - the number of divisions [SCALAR, default: 0]
        _dir - reference direction used to inform the algorithm [SCALAR, default: _defaultDir]
        _degrees - the degrees to divide into the total [SCALAR, default: _defaultDegrees]
        _totalDegrees - the total degrees [SCALAR, default: _defaultTotalDegrees]

    Returns:
        The calculated radial positions [ARRAY]
 */

[
    random 360
    , 45
    , 360
] params [
    "_defaultDir"
    , "_defaultDegrees"
    , "_defaultTotalDegrees"
];

params [
    ["_centerPos", +KPLIB_zeroPos, [[]], 3]
    , ["_range", 0, [0]]
    , ["_div", 0, [0]]
    , ["_dir", _defaultDir, [0]]
    , ["_degrees", _defaultDegrees, [0]]
    , ["_totalDegrees", _defaultTotalDegrees, [0]]
];

private _retval = [];
private _rangeDiv = _range / _div;

for "_i" from 0 to _div do {
    for "_j" from 0 to (_totalDegrees / _degrees) - 1 do {
        private _pos = _centerPos getPos [_rangeDiv * (_i + 1), (_dir + (_j * _degrees)) % _totalDegrees];
        _retval pushBack _pos;
    };
};

_retval;
