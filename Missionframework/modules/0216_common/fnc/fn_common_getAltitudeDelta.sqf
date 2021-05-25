/*
    KPLIB_fnc_common_getAltitudeDelta

    File: fn_common_getAltitudeDelta.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 19:10:34
    Last Update: 2021-05-23 12:35:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the ALTITUDE DELTA between two OBJECTS or POSITIONS or a mix of the two.

    Parameter(s):
        _alpha - the ALPHA object or position [OBJECT|POSITION, default: objNull]
        _bravo - the BRAVO object or position [OBJECT|POSITION, default: objNull]
        _absolute - whether to calculate in terms of absolute value [BOOL, default: true]

    Returns:
        The ALTITUDE DELTA between two OBJECTS or POSITIONS [SCALAR]
 */

params [
    ["_alpha", objNull, [objNull, []]]
    , ["_bravo", objNull, [objNull, []]]
    , ["_absolute", true, [true]]
];

private _positions = [_alpha, _bravo] apply {
    switch (true) do {
        case (_x isEqualType objNull): { getPos _x; };
        case (_x isEqualType []): { _x; };
        default { []; };
    };
};

_positions params [
    ["_alphaPos", [], [[]]]
    , ["_bravoPos", [], [[]]]
];

_alphaPos params ["_0", "_1", ["_alphaPosZ", 0, [0]]];
_bravoPos params ["_3", "_4", ["_bravoPosZ", 0, [0]]];

private _deltaZ = _alphaPosZ - _bravoPosZ;

if (_absolute) exitWith { abs _deltaZ; };

_deltaZ;
