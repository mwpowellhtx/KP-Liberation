/*
    KPLIB_fnc_resources_registerStoragePositions

    File: fn_resources_registerStoragePositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-21 20:32:21
    Last Update: 2021-02-21 20:32:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the offsets for use with the caller.

    Parameter(s):
        _xOffsets - X offset coordinates [ARRAY, default: []]
        _yOffsets - Y offset coordinates [ARRAY, default: []]
        _zOffset - Z offset coordinate

    Returns:
        The offsets aligning a matrix of the [X, Y, Z] offset coordinates.
 */

params [
    ["_xOffsets", [], [[]]]
    , ["_yOffsets", [], [[]]]
    , ["_zOffset", KPLIB_resources_storageOffsetZ, [0]]
];

private _retval = [];

private _xOffsetsCount = count _xOffsets;
private _yOffsetsCount = count _yOffsets;

// Y/j first, then X/i ...
for "_j" from 0 to (_yOffsetsCount - 1) do {
    [_yOffsets select _j] params ["_yOffset"];
    for "_i" from 0 to (_xOffsetsCount - 1) do {
        [_xOffsets select _i] params ["_xOffset"];
        _retval pushBackUnique [_xOffset, _yOffset, _zOffset];
    };
};

_retval;
