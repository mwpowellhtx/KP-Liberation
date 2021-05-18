/*
    KPLIB_fnc_common_getCirclePositions

    File: fn_common_getCirclePositions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-08-05
    Last Update: 2021-05-17 20:24:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Generates "_elements" amount of positions on an edge of circle with given "_radius"

    Parameter(s):
        _center     - Center of circle [POSITION, default: getPos player]
        _radius     - Radius of circle [NUMBER, default: KPLIB_param_fobs_range]
        _elements   - Amount of generated positions. Evenly distributed, more positions equals more density [NUMBER, default: nil]

    Returns:
        positions [_x, _y, _z, _angle] - false if wrong params [ARRAY/BOOL]
 */

params [
    ["_center", getPos player, [[]], 3],
    ["_radius", KPLIB_param_fobs_range, [0]],
    ["_elements", nil, [0]]
];

if (isNil "_elements") then { _elements = _radius };
// Input validation
if (_radius <= 0 || _elements <= 0) exitWith {false};

private _positions = [];

for "_i" from  0 to _elements do {
    private _angle = _i * (360/_elements);

    private _x = (_center select 0) + _radius * cos(_angle);
    private _y = (_center select 1) + _radius * sin(_angle);

    _positions pushBack [_x, _y, _center select 2, _angle];
 };

_positions
